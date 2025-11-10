package web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.CustomerDao;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
  private final CustomerDao customers = new CustomerDao();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    String first = req.getParameter("first_name");
    String last  = req.getParameter("last_name");
    String email = req.getParameter("email");
    String tel   = req.getParameter("telephone");
    String pw    = req.getParameter("password");

    try {
      if (email == null || pw == null || first == null || last == null) {
        req.setAttribute("error", "All required fields must be provided.");
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        return;
      }
      if (customers.emailExists(email)) {
        req.setAttribute("error", "Email is already registered.");
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        return;
      }
      int id = customers.insert(first, last, email, tel, pw);
      req.getSession(true).setAttribute("customerId", id);
      resp.sendRedirect(req.getContextPath() + "/pages/reservation.jsp");
    } catch (Exception e) {
      throw new ServletException("Registration failed", e);
    }
  }
}
