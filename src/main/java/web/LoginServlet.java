package web;

import dao.CustomerDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;

@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
  private final CustomerDao customers = new CustomerDao();

  @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    String email = req.getParameter("email");
    String pw    = req.getParameter("password");

    try {
      Integer id = customers.authenticate(email, pw);
      if (id == null) {
        req.setAttribute("error", "Invalid email or password.");
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        return;
      }
      HttpSession session = req.getSession(true);
      session.setAttribute("customerId", id);
      session.setAttribute("customerEmail", email);
      resp.sendRedirect(req.getContextPath() + "/pages/reservation.jsp");
    } catch (Exception e) {
      throw new ServletException("Login failed", e);
    }
  }
}
