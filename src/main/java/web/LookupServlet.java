package web;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;

@WebServlet(name="LookupServlet", urlPatterns={"/lookup"})
public class LookupServlet extends HttpServlet {
  @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // TODO: implement using ReservationDao (by reservation_id OR email)
    // req.setAttribute("results", results);
    req.getRequestDispatcher("/pages/reservation-summary.jsp").forward(req, resp);
  }
}
