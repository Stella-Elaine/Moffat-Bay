package web;

import dao.CustomerDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

  private final CustomerDao customers = new CustomerDao();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    req.setCharacterEncoding("UTF-8");

    String email = req.getParameter("email");
    String pw    = req.getParameter("password");

    try {
      if (email == null || pw == null || email.isBlank() || pw.isBlank()) {
        req.setAttribute("error", "Email and password are required.");
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        return;
      }

      // Test Case 1: email not found at all
      if (!customers.emailExists(email)) {
        req.setAttribute("error", "No account found with that email.");
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        return;
      }

      // Test Case 2: email exists, but password is wrong
      Integer id = customers.authenticate(email, pw);
      if (id == null) {
        req.setAttribute("error", "Incorrect password. Please try again.");
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        return;
      }

      //  Tests Case 3: success — set session + flash + redirect to reservation
      HttpSession session = req.getSession(true);
      session.setAttribute("customerId", id);

      session.setAttribute("flash_success", "Login successful. Welcome back!");

      resp.sendRedirect(req.getContextPath() + "/pages/reservation.jsp");

    } catch (Exception e) {
      throw new ServletException("Login failed", e);
    }
  }
}
