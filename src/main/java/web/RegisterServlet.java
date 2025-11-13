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
      if (email == null || pw == null || first == null || last == null
          || email.isBlank() || pw.isBlank() || first.isBlank() || last.isBlank()) {
        req.setAttribute("error", "All required fields must be provided.");
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        return;
      }

      //  Test 0duplicate email check
      if (customers.emailExists(email)) {
        req.setAttribute("error", "Email is already registered. Please log in instead.");
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        return;
      }

      //  test 1 create the user
      int id = customers.insert(first, last, email, tel, pw);

      // Test 2 keep them 'logged in' in the session
      HttpSession session = req.getSession(true);
      session.setAttribute("customerId", id);

      //  Test 3 success message shown on register.jsp
      req.setAttribute("success", first + ", your account has been created successfully!");

      // Test 4  forward back to the same page to show the message
      req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);

    } catch (Exception e) {
      req.setAttribute("error", "Registration failed unexpectedly. Please try again.");
      req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
    }
  }
}
