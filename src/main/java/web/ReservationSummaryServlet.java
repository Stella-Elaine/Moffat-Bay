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
    System.out.println("=== ReservationSummaryServlet.doGet ===");
    System.out.println("Query string: " + req.getQueryString());
    System.out.println("Status param: " + req.getParameter("status"));
    
    String idParam = req.getParameter("id");
    System.out.println("ID param: " + idParam);
    
    if (idParam == null) {
      Object sid = req.getSession(false) != null ? req.getSession(false).getAttribute("reservationId") : null;
      if (sid != null) idParam = String.valueOf(sid);
      System.out.println("ID from session: " + idParam);
    }
    if (idParam == null) {
      System.out.println("ERROR: Missing reservation ID, forwarding to reservation.jsp");
      req.setAttribute("error", "Missing reservation id.");
      req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
      return;
    }
    try {
      int id = Integer.parseInt(idParam);
      System.out.println("Loading reservation summary for ID: " + id);
      ReservationSummary summary = reservations.getReservationSummary(id);
      System.out.println("Summary loaded: " + (summary != null));
      if (summary != null) {
        System.out.println("Summary status: " + summary.getStatus());
      }
      
      if (summary == null) {
        System.out.println("ERROR: Reservation not found, forwarding to reservation.jsp");
        req.setAttribute("error", "Reservation not found.");
        req.getRequestDispatcher("/pages/reservation.jsp").forward(req, resp);
        return;
      }
      req.setAttribute("summary", summary);
      System.out.println("Forwarding to reservation-summary.jsp");
      req.getRequestDispatcher("/pages/reservation-summary.jsp").forward(req, resp);
    } catch (Exception e) {
      System.out.println("EXCEPTION: " + e.getMessage());
      e.printStackTrace();
      throw new ServletException("Failed to load reservation summary", e);
    }
  }
}
