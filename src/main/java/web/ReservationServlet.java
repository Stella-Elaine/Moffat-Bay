package web;

import dao.ReservationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;

@WebServlet(name = "ReservationServlet", urlPatterns = {"/reserve"})
public class ReservationServlet extends HttpServlet {
  private final ReservationDao reservations = new ReservationDao();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("customerId") == null) {
      // require login
      resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
      return;
    }
    Integer cidObj = (Integer) session.getAttribute("customerId");
    if (cidObj == null) {
      resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
      return;
    }
    int customerId = cidObj;

  String action = req.getParameter("action"); // "search" or "reserve"
  String in = req.getParameter("check_in");
  String out = req.getParameter("check_out");
  String guests = req.getParameter("guests");
  String roomType = req.getParameter("room_type_id");

    if (in == null || out == null || guests == null || roomType == null) {
      req.setAttribute("error", "All fields are required.");
      req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
      return;
    }

    try {
      LocalDate checkIn = LocalDate.parse(in);
      LocalDate checkOut = LocalDate.parse(out);
      if (!checkOut.isAfter(checkIn)) {
        req.setAttribute("error", "Check-out must be after check-in.");
        req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
        return;
      }
      int numGuests = Integer.parseInt(guests);
      int roomTypeId = Integer.parseInt(roomType);

      // Capacity check
      int maxGuests = reservations.getMaxGuests(roomTypeId);
      if (numGuests > maxGuests) {
        req.setAttribute("error", "Selected room type cannot accommodate that many guests.");
        req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
        return;
      }

      if ("search".equalsIgnoreCase(action)) {
        // Search step: produce list of ALL available rooms meeting guest capacity, preferred type first
        var availableRooms = reservations.listAvailableRoomsForGuests(roomTypeId, numGuests, checkIn, checkOut);
        if (availableRooms.isEmpty()) {
          req.setAttribute("error", "No rooms are free for the chosen dates and guest count.");
        } else {
          req.setAttribute("availableRooms", availableRooms);
          req.setAttribute("searchComplete", true);
        }
        // Keep user selections so the second step keeps context
        req.setAttribute("check_in", checkIn.toString());
        req.setAttribute("check_out", checkOut.toString());
        req.setAttribute("guests", numGuests);
        req.setAttribute("preferred_room_type_id", roomTypeId);
        req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
        return;
      }

      if ("reserve".equalsIgnoreCase(action)) {
        // Expect composite room choice: roomId:roomTypeId
        String choice = req.getParameter("room_choice");
        if (choice == null || !choice.contains(":")) {
          req.setAttribute("error", "Please select a room to reserve.");
          req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
          return;
        }
        String[] parts = choice.split(":");
        int roomId = Integer.parseInt(parts[0]);
        int chosenRoomTypeId = Integer.parseInt(parts[1]);
        // Re-validate availability (race condition safe)
        if (!reservations.isRoomAvailable(roomId, checkIn, checkOut)) {
          req.setAttribute("error", "That room was just booked. Please search again.");
          req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
          return;
        }
        // Price calculation
        BigDecimal nightly = reservations.getNightlyRate(chosenRoomTypeId);
        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        BigDecimal total = nightly.multiply(BigDecimal.valueOf(nights));

        int reservationId = reservations.createReservation(customerId, numGuests, checkIn, checkOut, total);
        if (reservationId < 0) throw new ServletException("Failed to create reservation");
        reservations.assignRoomToReservation(reservationId, roomId);
        session.setAttribute("reservationId", reservationId);
        resp.sendRedirect(req.getContextPath() + "/reservation-summary?id=" + reservationId);
        return;
      }

      req.setAttribute("error", "Unknown action.");
      req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
    } catch (DateTimeParseException | NumberFormatException e) {
      req.setAttribute("error", "Invalid input format.");
      req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
    } catch (Exception e) {
      throw new ServletException("Reservation failed", e);
    }
  }
}
