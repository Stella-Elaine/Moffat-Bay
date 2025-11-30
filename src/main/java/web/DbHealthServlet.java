package web;

import db.Db;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

/** Simple health check servlet to verify DB connectivity and basic query execution. */
@WebServlet(name = "DbHealthServlet", urlPatterns = {"/db-health"})
public class DbHealthServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    resp.setContentType("text/plain;charset=UTF-8");
    try (PrintWriter out = resp.getWriter()) {
      long start = System.nanoTime();
      try (Connection c = Db.get(); Statement st = c.createStatement()) {
        try (ResultSet rs = st.executeQuery("SELECT 1")) {
          if (rs.next()) {
            long elapsedMs = (System.nanoTime() - start) / 1_000_000L;
            out.println("STATUS: OK");
            out.println("QUERY: SELECT 1 -> " + rs.getInt(1));
            out.println("AutoCommit: " + c.getAutoCommit());
            out.println("LatencyMs: " + elapsedMs);
          } else {
            resp.setStatus(500);
            out.println("STATUS: FAIL (no result from SELECT 1)");
          }
        }
      } catch (Exception e) {
        resp.setStatus(500);
        out.println("STATUS: FAIL");
        out.println("ERROR: " + e.getClass().getName() + ": " + e.getMessage());
      }
    }
  }
}
