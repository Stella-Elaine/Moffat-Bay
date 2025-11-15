package web;

import dao.ReservationDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import model.ReservationListItem;
import model.ReservationSummary;

import java.io.IOException;
import java.util.List;

@WebServlet(name="LookupServlet", urlPatterns={"/lookup"})
public class LookupServlet extends HttpServlet {
  private final ReservationDao reservations = new ReservationDao();

  @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    String idParam = req.getParameter("reservation_id");
    String email   = req.getParameter("email");

    try {
      if (idParam != null && !idParam.isBlank()) {
        int id = Integer.parseInt(idParam);
        ReservationSummary summary = reservations.findReservationById(id);
        if (summary == null) {
          req.setAttribute("error", "No reservation found for reference #" + id + ".");
          req.getRequestDispatcher("/pages/lookup.jsp").forward(req, resp);
          return;
        }
        req.setAttribute("summary", summary);
        req.getRequestDispatcher("/pages/reservation-summary.jsp").forward(req, resp);
        return;
      }

      if (email != null && !email.isBlank()) {
        List<ReservationListItem> list = reservations.findReservationsByEmail(email.trim());
        if (list.isEmpty()) {
          req.setAttribute("error", "No reservations found for that email address.");
        }
        req.setAttribute("results", list);
        req.setAttribute("email", email);
        req.getRequestDispatcher("/pages/lookup.jsp").forward(req, resp);
        return;
      }

      // No query input provided
      req.setAttribute("error", "Enter a reservation ID or an email to search.");
      req.getRequestDispatcher("/pages/lookup.jsp").forward(req, resp);
    } catch (NumberFormatException nfe) {
      req.setAttribute("error", "Reservation ID must be a number.");
      req.getRequestDispatcher("/pages/lookup.jsp").forward(req, resp);
    } catch (Exception e) {
      throw new ServletException("Lookup failed", e);
    }
  }
}
