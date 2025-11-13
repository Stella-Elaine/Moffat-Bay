package web;

import dao.ReservationDao;
import dao.CustomerDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.EmailService;
import model.ReservationSummary;

import java.io.IOException;

@WebServlet(name = "CancelReservationServlet", urlPatterns = {"/reservation-cancel"})
public class CancelReservationServlet extends HttpServlet {
  private final ReservationDao reservations = new ReservationDao();
  private final CustomerDao customers = new CustomerDao();
  private final EmailService email = new EmailService();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("customerId") == null) {
      resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
      return;
    }
    Integer customerId = (Integer) session.getAttribute("customerId");
    String idParam = req.getParameter("id");
    if (idParam == null) {
      req.setAttribute("error", "Missing reservation id.");
      req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
      return;
    }
    try {
      int reservationId = Integer.parseInt(idParam);
      if (!reservations.isReservationOwnedBy(reservationId, customerId)) {
        req.setAttribute("error", "You do not have permission to cancel this reservation.");
        req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
        return;
      }
      boolean ok = reservations.cancelReservation(reservationId);
      if (!ok) throw new ServletException("Cancellation failed");

      // Email cancellation confirmation (best-effort)
      try {
        ReservationSummary summary = reservations.getReservationSummary(reservationId);
        String to = (String) session.getAttribute("customerEmail");
        if (to == null) to = customers.getEmail(customerId);
        if (summary != null && to != null) {
          String subject = "Your Moffat Bay reservation #" + reservationId + " cancelled";
          String body = "Your reservation has been cancelled.\n" +
                  "Reservation ID: " + reservationId + "\n" +
                  "Original check-in: " + summary.getCheckIn() + "\n" +
                  "Original check-out: " + summary.getCheckOut() + "\n" +
                  "If this was a mistake, please book again.";
          email.send(to, subject, body);
        }
      } catch (Exception mailEx) {
        getServletContext().log("Cancel email failed: " + mailEx.getMessage());
      }

      resp.sendRedirect(req.getContextPath() + "/reservation-summary?id=" + reservationId);
    } catch (Exception e) {
      throw new ServletException("Unable to cancel reservation", e);
    }
  }
}
