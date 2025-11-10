package dao;

import db.Db;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;

public class ReservationDao {

  public BigDecimal getNightlyRate(int roomTypeId) throws SQLException {
    final String sql = "SELECT price_per_night FROM room_types WHERE room_type_id = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, roomTypeId);
      try (ResultSet rs = ps.executeQuery()) {
        if (!rs.next()) throw new SQLException("Unknown room_type_id: " + roomTypeId);
        return rs.getBigDecimal(1);
      }
    }
  }

  public int createReservation(int customerId,
                              int roomTypeId,
                              int numGuests,
                              LocalDate checkIn,
                              LocalDate checkOut,
                              BigDecimal totalPrice) throws SQLException {
    final String sql = """
      INSERT INTO reservations(customer_id, room_type_id, num_guests, check_in_date, check_out_date, total_price, status)
      VALUES(?,?,?,?,?,?,'Confirmed')
      """;
    try (Connection c = Db.get();
         PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      ps.setInt(1, customerId);
      ps.setInt(2, roomTypeId);
      ps.setInt(3, numGuests);
      ps.setDate(4, Date.valueOf(checkIn));
      ps.setDate(5, Date.valueOf(checkOut));
      ps.setBigDecimal(6, totalPrice);
      ps.executeUpdate();
      try (ResultSet keys = ps.getGeneratedKeys()) {
        return keys.next() ? keys.getInt(1) : -1;
      }
    }
  }
}

