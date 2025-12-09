package web;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * CSRF Protection Filter
 * Generates tokens for GET requests and validates them on state-changing POST requests.
 */
@WebFilter(filterName = "CsrfFilter", urlPatterns = {"/*"})
public class CsrfFilter implements Filter {
  private static final String CSRF_TOKEN_ATTR = "csrfToken";
  private static final String CSRF_PARAM_NAME = "csrf_token";
  private static final SecureRandom random = new SecureRandom();

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse resp = (HttpServletResponse) response;

    // Generate token for all requests that might render forms
    HttpSession session = req.getSession(false);
    if (session != null && session.getAttribute(CSRF_TOKEN_ATTR) == null) {
      session.setAttribute(CSRF_TOKEN_ATTR, generateToken());
    }

    // Validate CSRF token on POST requests to protected endpoints
    if ("POST".equalsIgnoreCase(req.getMethod())) {
      String path = req.getServletPath();
      
      // Protected endpoints that modify state
      if (path.equals("/register") || path.equals("/login") || 
          path.equals("/reserve") || path.equals("/reservation-cancel")) {
        
        if (session == null) {
          resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
          return;
        }

        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        String requestToken = req.getParameter(CSRF_PARAM_NAME);

        if (sessionToken == null || !sessionToken.equals(requestToken)) {
          resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
          return;
        }
      }
    }

    chain.doFilter(request, response);
  }

  private String generateToken() {
    byte[] bytes = new byte[32];
    random.nextBytes(bytes);
    return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
  }
}
