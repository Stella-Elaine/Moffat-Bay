package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class ReservationListItem {
  private final int reservationId;
  private final LocalDate checkIn;
  private final LocalDate checkOut;
  private final String status;
  private final BigDecimal totalCost;

  public ReservationListItem(int reservationId, LocalDate checkIn, LocalDate checkOut, String status, BigDecimal totalCost) {
    this.reservationId = reservationId;
    this.checkIn = checkIn;
    this.checkOut = checkOut;
    this.status = status;
    this.totalCost = totalCost;
  }

  public int getReservationId() { return reservationId; }
  public LocalDate getCheckIn() { return checkIn; }
  public LocalDate getCheckOut() { return checkOut; }
  public String getStatus() { return status; }
  public BigDecimal getTotalCost() { return totalCost; }
}
