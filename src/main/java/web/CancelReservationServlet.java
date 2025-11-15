package web;

import dao.ReservationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "CancelReservationServlet", urlPatterns = {"/reservation-cancel"})
public class CancelReservationServlet extends HttpServlet {
  private final ReservationDao reservations = new ReservationDao();

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

      resp.sendRedirect(req.getContextPath() + "/reservation-summary?id=" + reservationId + "&status=cancelled");
    } catch (Exception e) {
      throw new ServletException("Unable to cancel reservation", e);
    }
  }
}
