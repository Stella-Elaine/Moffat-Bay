package dao;

import db.Db;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class CustomerDao {

  public boolean emailExists(String email) throws SQLException {
    final String sql = "SELECT 1 FROM customers WHERE email = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setString(1, email);
      try (ResultSet rs = ps.executeQuery()) {
        return rs.next();
      }
    }
  }

  public int insert(String first, String last, String email, String telephone, String rawPassword) throws SQLException {
    String hash = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));
    final String sql = """
        INSERT INTO customers(first_name,last_name,email,telephone,password_hash)
        VALUES(?,?,?,?,?)
        """;
    try (Connection c = Db.get();
         PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      ps.setString(1, first);
      ps.setString(2, last);
      ps.setString(3, email);
      ps.setString(4, telephone);
      ps.setString(5, hash);
      ps.executeUpdate();
      try (ResultSet keys = ps.getGeneratedKeys()) {
        return keys.next() ? keys.getInt(1) : -1;
      }
    }
  }

  /** @return customer_id if authenticated; null otherwise */
  public Integer authenticate(String email, String rawPassword) throws SQLException {
    final String sql = "SELECT customer_id, password_hash FROM customers WHERE email = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setString(1, email);
      try (ResultSet rs = ps.executeQuery()) {
        if (!rs.next()) return null;
        int id = rs.getInt("customer_id");
        String hash = rs.getString("password_hash");
        return BCrypt.checkpw(rawPassword, hash) ? id : null;
      }
    }
  }

  public String getEmail(int customerId) throws SQLException {
    final String sql = "SELECT email FROM customers WHERE customer_id = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, customerId);
      try (ResultSet rs = ps.executeQuery()) {
        return rs.next() ? rs.getString(1) : null;
      }
    }
  }
}
