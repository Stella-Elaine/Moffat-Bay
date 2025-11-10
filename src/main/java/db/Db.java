package db;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/** Centralized JNDI DataSource lookup for jdbc/MoffatBayDS. */
public final class Db {
  private static final DataSource DS;
  static {
    try {
      DS = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/MoffatBayDS");
    } catch (NamingException e) {
      throw new ExceptionInInitializerError("JNDI DataSource lookup failed: " + e.getMessage());
    }
  }
  private Db() {}
  public static Connection get() throws SQLException {
    return DS.getConnection();
  }
}
