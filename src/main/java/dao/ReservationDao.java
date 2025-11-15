package dao;

import db.Db;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.RoomOption;
import model.ReservationSummary;

/**
 * Reservation-related DB operations.
 * Adjusted to match database schema in database/schema.sql
 */
public class ReservationDao {

  /** Get nightly rate for a room type. */
  public BigDecimal getNightlyRate(int roomTypeId) throws SQLException {
    final String sql = "SELECT rate FROM room_types WHERE room_type_id = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, roomTypeId);
      try (ResultSet rs = ps.executeQuery()) {
        if (!rs.next()) throw new SQLException("Unknown room_type_id: " + roomTypeId);
        return rs.getBigDecimal(1);
      }
    }
  }

  /** Get maximum guests allowed for a room type. */
  public int getMaxGuests(int roomTypeId) throws SQLException {
    final String sql = "SELECT max_guests FROM room_types WHERE room_type_id = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, roomTypeId);
      try (ResultSet rs = ps.executeQuery()) {
        if (!rs.next()) throw new SQLException("Unknown room_type_id: " + roomTypeId);
        return rs.getInt(1);
      }
    }
  }

  /**
   * Find an available physical room id for the given room type and date range.
   * Returns -1 if none available.
   */
  public int findAvailableRoom(int roomTypeId, LocalDate checkIn, LocalDate checkOut) throws SQLException {
    final String sql =
      "SELECT r.room_id FROM rooms r " +
      "WHERE r.room_type_id = ? AND r.room_status = 'Available' AND r.room_id NOT IN (" +
      "  SELECT rr.room_id FROM reservation_rooms rr JOIN reservations res ON rr.reservation_id = res.reservation_id " +
      "  WHERE NOT (res.check_out <= ? OR res.check_in >= ?)" +
      ") LIMIT 1";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, roomTypeId);
      ps.setDate(2, Date.valueOf(checkIn));
      ps.setDate(3, Date.valueOf(checkOut));
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getInt(1);
        return -1;
      }
    }
  }

  /** List all available rooms for a type and date range (basic). */
  public List<RoomOption> listAvailableRooms(int roomTypeId, LocalDate checkIn, LocalDate checkOut) throws SQLException {
    final String sql =
      "SELECT r.room_id, r.room_number, rt.room_type_id, rt.type_name, rt.rate, rt.max_guests " +
      "FROM rooms r JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
      "WHERE r.room_type_id = ? AND r.room_status = 'Available' AND r.room_id NOT IN (" +
      "  SELECT rr.room_id FROM reservation_rooms rr JOIN reservations res ON rr.reservation_id = res.reservation_id " +
      "  WHERE NOT (res.check_out <= ? OR res.check_in >= ?)" +
      ") ORDER BY r.room_number";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, roomTypeId);
      ps.setDate(2, Date.valueOf(checkIn));
      ps.setDate(3, Date.valueOf(checkOut));
      try (ResultSet rs = ps.executeQuery()) {
        List<RoomOption> list = new ArrayList<>();
        while (rs.next()) {
          list.add(new RoomOption(
            rs.getInt("room_id"),
            rs.getString("room_number"),
            rs.getInt("room_type_id"),
            rs.getString("type_name"),
            rs.getBigDecimal("rate"),
            rs.getInt("max_guests")
          ));
        }
        return list;
      }
    }
  }

  /** List all available rooms across types that can fit given guests, preferred type first. */
  public List<RoomOption> listAvailableRoomsForGuests(int preferredRoomTypeId, int guests, LocalDate checkIn, LocalDate checkOut) throws SQLException {
    final String sql =
      "SELECT r.room_id, r.room_number, rt.room_type_id, rt.type_name, rt.rate, rt.max_guests " +
      "FROM rooms r JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
      "WHERE rt.max_guests >= ? AND r.room_status = 'Available' AND r.room_id NOT IN (" +
      "  SELECT rr.room_id FROM reservation_rooms rr JOIN reservations res ON rr.reservation_id = res.reservation_id " +
      "  WHERE NOT (res.check_out <= ? OR res.check_in >= ?)" +
      ") " +
      "ORDER BY CASE WHEN rt.room_type_id = ? THEN 0 ELSE 1 END, rt.rate ASC, r.room_number ASC";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, guests);
      ps.setDate(2, Date.valueOf(checkIn));
      ps.setDate(3, Date.valueOf(checkOut));
      ps.setInt(4, preferredRoomTypeId);
      try (ResultSet rs = ps.executeQuery()) {
        List<RoomOption> list = new ArrayList<>();
        while (rs.next()) {
          list.add(new RoomOption(
            rs.getInt("room_id"),
            rs.getString("room_number"),
            rs.getInt("room_type_id"),
            rs.getString("type_name"),
            rs.getBigDecimal("rate"),
            rs.getInt("max_guests")
          ));
        }
        return list;
      }
    }
  }

  /** Verify a specific room is still available for the window. */
  public boolean isRoomAvailable(int roomId, LocalDate checkIn, LocalDate checkOut) throws SQLException {
    final String sql =
      "SELECT 1 FROM reservation_rooms rr " +
      "JOIN reservations res ON rr.reservation_id = res.reservation_id " +
      "WHERE rr.room_id = ? AND NOT (res.check_out <= ? OR res.check_in >= ?) LIMIT 1";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, roomId);
      ps.setDate(2, Date.valueOf(checkIn));
      ps.setDate(3, Date.valueOf(checkOut));
      try (ResultSet rs = ps.executeQuery()) {
        return !rs.next(); // available if no overlapping row exists
      }
    }
  }

  /**
   * Create a reservation record and return generated reservation_id.
   */
  public int createReservation(int customerId,
                               int numGuests,
                               LocalDate checkIn,
                               LocalDate checkOut,
                               BigDecimal totalCost) throws SQLException {
    final String sql = "INSERT INTO reservations(customer_id, num_guests, check_in, check_out, total_cost, status) VALUES(?,?,?,?,?, 'Confirmed')";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      ps.setInt(1, customerId);
      ps.setInt(2, numGuests);
      ps.setDate(3, Date.valueOf(checkIn));
      ps.setDate(4, Date.valueOf(checkOut));
      ps.setBigDecimal(5, totalCost);
      ps.executeUpdate();
      try (ResultSet keys = ps.getGeneratedKeys()) {
        return keys.next() ? keys.getInt(1) : -1;
      }
    }
  }

  /** Assign a physical room to a reservation. */
  public void assignRoomToReservation(int reservationId, int roomId) throws SQLException {
    final String sql = "INSERT INTO reservation_rooms(reservation_id, room_id) VALUES(?,?)";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, reservationId);
      ps.setInt(2, roomId);
      ps.executeUpdate();
    }
  }

  /** Retrieve detailed reservation info for summary display. */
  public ReservationSummary getReservationSummary(int reservationId) throws SQLException {
    final String sql = "" +
      "SELECT res.reservation_id, res.num_guests, res.check_in, res.check_out, res.total_cost, res.status, " +
      "c.first_name, c.last_name, c.email, rt.type_name, r.room_number " +
      "FROM reservations res " +
      "JOIN customers c ON res.customer_id = c.customer_id " +
      "LEFT JOIN reservation_rooms rr ON rr.reservation_id = res.reservation_id " +
      "LEFT JOIN rooms r ON rr.room_id = r.room_id " +
      "LEFT JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
      "WHERE res.reservation_id = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, reservationId);
      try (ResultSet rs = ps.executeQuery()) {
        java.util.List<String> roomNumbers = new java.util.ArrayList<>();
        int resId = -1, numGuests = 0; java.time.LocalDate checkIn = null, checkOut = null; java.math.BigDecimal totalCost = null; String status = null; String first=null,last=null,email=null, typeName=null;
        while (rs.next()) {
          if (resId == -1) {
            resId = rs.getInt("reservation_id");
            numGuests = rs.getInt("num_guests");
            checkIn = rs.getDate("check_in").toLocalDate();
            checkOut = rs.getDate("check_out").toLocalDate();
            totalCost = rs.getBigDecimal("total_cost");
            status = rs.getString("status");
            first = rs.getString("first_name");
            last = rs.getString("last_name");
            email = rs.getString("email");
            typeName = rs.getString("type_name");
          }
          String roomNum = rs.getString("room_number");
          if (roomNum != null) {
            roomNumbers.add(roomNum);
          }
        }
        if (resId == -1) return null; // not found
        // If cancelled and no rooms, use generic message
        if (roomNumbers.isEmpty()) {
          roomNumbers.add("N/A");
          if (typeName == null) typeName = "N/A";
        }
        return new ReservationSummary(resId, first, last, email, checkIn, checkOut, numGuests, totalCost, status, roomNumbers, typeName);
      }
    }
  }

  /** Ensure the reservation belongs to the given customer. */
  public boolean isReservationOwnedBy(int reservationId, int customerId) throws SQLException {
    final String sql = "SELECT 1 FROM reservations WHERE reservation_id = ? AND customer_id = ?";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setInt(1, reservationId);
      ps.setInt(2, customerId);
      try (ResultSet rs = ps.executeQuery()) {
        return rs.next();
      }
    }
  }

  /** Cancel a reservation: free any room holds and set status to Cancelled. */
  public boolean cancelReservation(int reservationId) throws SQLException {
    String delRooms = "DELETE FROM reservation_rooms WHERE reservation_id = ?";
    String updRes   = "UPDATE reservations SET status = 'Cancelled' WHERE reservation_id = ?";
    try (Connection c = Db.get()) {
      boolean old = c.getAutoCommit();
      c.setAutoCommit(false);
      try (PreparedStatement ps1 = c.prepareStatement(delRooms); PreparedStatement ps2 = c.prepareStatement(updRes)) {
        ps1.setInt(1, reservationId);
        ps1.executeUpdate();
        ps2.setInt(1, reservationId);
        int updated = ps2.executeUpdate();
        c.commit();
        c.setAutoCommit(old);
        return updated > 0;
      } catch (SQLException ex) {
        c.rollback();
        throw ex;
      }
    }
  }

  /** Find reservations by customer email (basic listing). */
  public List<model.ReservationListItem> findReservationsByEmail(String email) throws SQLException {
    final String sql = "SELECT res.reservation_id, res.check_in, res.check_out, res.status, res.total_cost " +
      "FROM reservations res JOIN customers c ON res.customer_id = c.customer_id WHERE c.email = ? ORDER BY res.check_in DESC";
    try (Connection c = Db.get(); PreparedStatement ps = c.prepareStatement(sql)) {
      ps.setString(1, email);
      try (ResultSet rs = ps.executeQuery()) {
        List<model.ReservationListItem> list = new ArrayList<>();
        while (rs.next()) {
          list.add(new model.ReservationListItem(
            rs.getInt("reservation_id"),
            rs.getDate("check_in").toLocalDate(),
            rs.getDate("check_out").toLocalDate(),
            rs.getString("status"),
            rs.getBigDecimal("total_cost")
          ));
        }
        return list;
      }
    }
  }

  /** Find single reservation by id (summary). */
  public ReservationSummary findReservationById(int reservationId) throws SQLException {
    return getReservationSummary(reservationId); // reuse existing detailed method
  }
}

