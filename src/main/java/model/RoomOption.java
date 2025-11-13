package model;

import java.math.BigDecimal;

/** View model for available room selection on reservation.jsp */
public class RoomOption {
  private final int roomId;
  private final String roomNumber;
  private final int roomTypeId;
  private final String roomTypeName;
  private final BigDecimal nightlyRate;
  private final int maxGuests;

  public RoomOption(int roomId, String roomNumber, int roomTypeId, String roomTypeName, BigDecimal nightlyRate, int maxGuests) {
    this.roomId = roomId;
    this.roomNumber = roomNumber;
    this.roomTypeId = roomTypeId;
    this.roomTypeName = roomTypeName;
    this.nightlyRate = nightlyRate;
    this.maxGuests = maxGuests;
  }

  public int getRoomId() { return roomId; }
  public String getRoomNumber() { return roomNumber; }
  public int getRoomTypeId() { return roomTypeId; }
  public String getRoomTypeName() { return roomTypeName; }
  public BigDecimal getNightlyRate() { return nightlyRate; }
  public int getMaxGuests() { return maxGuests; }
}
