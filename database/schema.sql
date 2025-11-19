-- =========
-- Database
-- =========
DROP DATABASE IF EXISTS moffat_bay;
CREATE DATABASE moffat_bay
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE moffat_bay;

-- ====================
-- Application DB User
-- ====================
DROP USER IF EXISTS 'student'@'%';
CREATE USER 'student'@'%' IDENTIFIED BY 'Student#01';
GRANT ALL PRIVILEGES ON moffat_bay.* TO 'student'@'%';
FLUSH PRIVILEGES;

-- =======================
-- Tables (Final ERD)
-- =======================

-- Customers
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id    INT AUTO_INCREMENT PRIMARY KEY,
  first_name     VARCHAR(50) NOT NULL,
  last_name      VARCHAR(50) NOT NULL,
  email          VARCHAR(100) NOT NULL,
  telephone      VARCHAR(20),
  password_hash  VARCHAR(255) NOT NULL,
  created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_customers_email UNIQUE (email)
) ENGINE=InnoDB;

-- Room types (lookup: rates & capacity)
DROP TABLE IF EXISTS room_types;
CREATE TABLE room_types (
  room_type_id     INT AUTO_INCREMENT PRIMARY KEY,
  type_name        VARCHAR(50) NOT NULL,       -- Double Full, Queen, Double Queen, King
  rate             DECIMAL(6,2) NOT NULL,      -- per-night price
  max_guests       INT NOT NULL,               -- capacity limit for validation
  description      TEXT
) ENGINE=InnoDB;

-- Physical rooms (inventory)
DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
  room_id       INT AUTO_INCREMENT PRIMARY KEY,
  room_type_id  INT NOT NULL,
  room_number   VARCHAR(10) NOT NULL,
  room_status   ENUM('Available','Booked','Out of Service') NOT NULL DEFAULT 'Available',
  CONSTRAINT uq_rooms_room_number UNIQUE (room_number),
  CONSTRAINT fk_rooms_roomtype
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Reservations (one reservation may include one or more room assignments via reservation_rooms)
DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations (
  reservation_id  INT AUTO_INCREMENT PRIMARY KEY,
  customer_id     INT NOT NULL,
  num_guests      INT NOT NULL,
  check_in        DATE NOT NULL,
  check_out       DATE NOT NULL,
  total_cost      DECIMAL(8,2) NOT NULL,
  status          ENUM('Pending','Confirmed','Checked-in','Completed','Cancelled')
                    NOT NULL DEFAULT 'Confirmed',
  created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_res_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ck_res_dates CHECK (check_out > check_in),
  CONSTRAINT ck_res_guests CHECK (num_guests > 0)
) ENGINE=InnoDB;

-- Junction: reservation ↔ rooms (supports assigning specific rooms)
DROP TABLE IF EXISTS reservation_rooms;
CREATE TABLE reservation_rooms (
  reservation_id  INT NOT NULL,
  room_id         INT NOT NULL,
  PRIMARY KEY (reservation_id, room_id),
  CONSTRAINT fk_rr_reservation
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT fk_rr_room
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Helpful indexes for lookups & reports
CREATE INDEX idx_res_customer ON reservations(customer_id);
CREATE INDEX idx_res_dates ON reservations(check_in, check_out);
CREATE INDEX idx_room_roomtype ON rooms(room_type_id);
CREATE INDEX idx_rr_room ON reservation_rooms(room_id);
CREATE INDEX idx_rr_res ON reservation_rooms(reservation_id);

-- =======================
-- Seed Data
-- =======================

-- Room types and prices per assignment
INSERT INTO room_types (type_name, rate, max_guests, description) VALUES
  ('Double Full', 126.00, 2, 'Cozy option for compact stays.'),         -- 120.00 * 1.05
  ('Queen',       141.75, 2, 'Balanced space and comfort.'),            -- 135.00 * 1.05
  ('Double Queen',157.50, 4, 'Great for families or friends.'),         -- 150.00 * 1.05
  ('King',        168.00, 2, 'Spacious comfort with king bed.');        -- 160.00 * 1.05

-- Migration note: To apply the 5% increase to existing databases without reseeding:
-- UPDATE room_types SET rate = ROUND(rate * 1.05, 2);

-- Sample physical rooms (adjust counts as you like)
-- Double Full: DF101-DF110 (10 rooms)
INSERT INTO rooms (room_type_id, room_number) VALUES
  (1,'DF101'),(1,'DF102'),(1,'DF103'),(1,'DF104'),(1,'DF105'),
  (1,'DF106'),(1,'DF107'),(1,'DF108'),(1,'DF109'),(1,'DF110');

-- Queen: Q201-Q210 (10 rooms)
INSERT INTO rooms (room_type_id, room_number) VALUES
  (2,'Q201'),(2,'Q202'),(2,'Q203'),(2,'Q204'),(2,'Q205'),
  (2,'Q206'),(2,'Q207'),(2,'Q208'),(2,'Q209'),(2,'Q210');

-- Double Queen: DQ301-DQ308 (8 rooms)
INSERT INTO rooms (room_type_id, room_number) VALUES
  (3,'DQ301'),(3,'DQ302'),(3,'DQ303'),(3,'DQ304'),
  (3,'DQ305'),(3,'DQ306'),(3,'DQ307'),(3,'DQ308');

-- King: K401-K406 (6 rooms)
INSERT INTO rooms (room_type_id, room_number) VALUES
  (4,'K401'),(4,'K402'),(4,'K403'),(4,'K404'),(4,'K405'),(4,'K406');

-- Sample customers — Based on User Personas,replace hash in app at runtime
-- Customers
INSERT INTO customers (first_name, last_name, email, telephone, password_hash) VALUES
  ('Leah', 'Travels', 'leah.travels@example.com', '360-555-1111', 'hash1'),
  ('Sam', 'Parents', 'sam.parents@example.com', '360-555-2222', 'hash2'),
  ('Ron', 'Returns', 'ron.returns@example.com', '360-555-3333', 'hash3');

-- Sample reservations and room assignments
-- Reservations
INSERT INTO reservations (customer_id, num_guests, check_in, check_out, total_cost, status) VALUES
  (1, 2, '2025-12-01', '2025-12-03', 252.00, 'Confirmed'),  -- 2 nights * 126.00 (updated Double Full)
  (2, 2, '2025-12-05', '2025-12-07', 283.50, 'Pending'),   -- 2 nights * 141.75 (updated Queen)
  (3, 2, '2025-12-10', '2025-12-12', 336.00, 'Confirmed');  -- 2 nights * 168.00 (updated King)

-- Reservation ↔ Rooms
INSERT INTO reservation_rooms (reservation_id, room_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3);

-- Test Queries:
-- use moffat_bay;
-- Show tables;
-- Select * from customers;
-- Select * from reservation_rooms;
-- Select * from reservations;
-- Select * from room_types;
-- Select * from rooms;