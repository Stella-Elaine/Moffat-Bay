package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class ReservationSummary {
  private final int reservationId;
  private final String customerFirstName;
  private final String customerLastName;
  private final String customerEmail;
  private final LocalDate checkIn;
  private final LocalDate checkOut;
  private final int numGuests;
  private final BigDecimal totalCost;
  private final String status;
  private final List<String> roomNumbers;
  private final String roomTypeName; // assuming single type per reservation in our flow

  public ReservationSummary(int reservationId, String customerFirstName, String customerLastName, String customerEmail,
                            LocalDate checkIn, LocalDate checkOut, int numGuests, BigDecimal totalCost, String status,
                            List<String> roomNumbers, String roomTypeName) {
    this.reservationId = reservationId;
    this.customerFirstName = customerFirstName;
    this.customerLastName = customerLastName;
    this.customerEmail = customerEmail;
    this.checkIn = checkIn;
    this.checkOut = checkOut;
    this.numGuests = numGuests;
    this.totalCost = totalCost;
    this.status = status;
    this.roomNumbers = roomNumbers;
    this.roomTypeName = roomTypeName;
  }

  public int getReservationId() { return reservationId; }
  public String getCustomerFirstName() { return customerFirstName; }
  public String getCustomerLastName() { return customerLastName; }
  public String getCustomerEmail() { return customerEmail; }
  public LocalDate getCheckIn() { return checkIn; }
  public LocalDate getCheckOut() { return checkOut; }
  public int getNumGuests() { return numGuests; }
  public BigDecimal getTotalCost() { return totalCost; }
  public String getStatus() { return status; }
  public List<String> getRoomNumbers() { return roomNumbers; }
  public String getRoomTypeName() { return roomTypeName; }
}
