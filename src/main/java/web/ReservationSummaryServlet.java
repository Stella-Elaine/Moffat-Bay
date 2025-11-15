package web;

import dao.ReservationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ReservationSummary;

import java.io.IOException;

@WebServlet(name = "ReservationSummaryServlet", urlPatterns = {"/reservation-summary"})
public class ReservationSummaryServlet extends HttpServlet {
  private final ReservationDao reservations = new ReservationDao();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String idParam = req.getParameter("id");
    if (idParam == null) {
      Object sid = req.getSession(false) != null ? req.getSession(false).getAttribute("reservationId") : null;
      if (sid != null) idParam = String.valueOf(sid);
    }
    if (idParam == null) {
      req.setAttribute("error", "Missing reservation id.");
      req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
      return;
    }
    try {
      int id = Integer.parseInt(idParam);
      ReservationSummary summary = reservations.getReservationSummary(id);
      if (summary == null) {
        req.setAttribute("error", "Reservation not found.");
        req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
        return;
      }
      req.setAttribute("summary", summary);
      req.getRequestDispatcher("/pages/reservation-summary.jsp").forward(req, resp);
    } catch (Exception e) {
      throw new ServletException("Failed to load reservation summary", e);
    }
  }
}
