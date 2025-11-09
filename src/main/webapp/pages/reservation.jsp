<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Book Your Stay – Moffat Bay Lodge</title>
  <link rel="stylesheet" href="stylesheets/styles.css" />
  <style>
    .hero{ --hero: url('photos/hero-lighthouse-coast.jpg'); }
  </style>
</head>
<body>
<header class="site-header">
  <div class="container bar">
    <div class="brand">
      <div class="title">Moffat Bay Lodge</div>
      <div class="sub">Joviedsa Island • San Juan Islands, Washington</div>
    </div>
    <nav>
      <ul>
        <li><a href="index.jsp">Home</a></li><li><a href="about.jsp">About</a></li>
        <li><a href="contact.jsp">Contact</a></li><li><a href="register.jsp">Register</a></li>
        <li><a href="login.jsp">Login</a></li><li><a href="attractions.jsp">Attractions</a></li>
        <li><a href="lookup.jsp">Reservation Lookup</a></li>
      </ul>
    </nav>
  </div>
</header>

<section class="hero">
  <div class="inner">
    <h1>Make a Reservation</h1>
    <p>Choose your room type, dates, and guests.</p>
  </div>
</section>

<section class="container mt-3">
  <form class="card" onsubmit="return false;">
    <div class="grid grid-3">
      <div>
        <label for="in">Check In Date</label>
        <input id="in" type="date" required />
      </div>
      <div>
        <label for="out">Check Out Date</label>
        <input id="out" type="date" required />
      </div>
      <div>
        <label for="guests">Guests</label>
        <select id="guests">
          <option>1</option><option>2</option><option>3</option><option>4</option>
        </select>
      </div>
    </div>

    <div class="grid grid-3 mt-2">
      <div>
        <label for="room">Room Selection</label>
        <select id="room">
          <option>Double Full Beds – $120/night</option>
          <option>Queen – $135/night</option>
          <option>Double Queen Beds – $150/night</option>
          <option>King – $160/night</option>
        </select>
      </div>
      <div></div><div></div>
    </div>

    <a class="btn mt-2" href="reservation-summary.jsp">Search Availability</a>
  </form>

  <h2 class="section-title">Room Options (Preview)</h2>
  <div class="grid grid-3">
    <div class="card">
      <div class="thumb"><img alt="Double full"
        src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Hotel_room_two_beds.jpg/1280px-Hotel_room_two_beds.jpg"></div>
      <h3>Double Full</h3>
      <p>Cozy option for compact stays.</p>
    </div>

    <div class="card">
      <div class="thumb"><img alt="Queen"
        src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Hotel_room_queen_bed.jpg/1280px-Hotel_room_queen_bed.jpg"></div>
      <h3>Queen</h3>
      <p>Balanced space and comfort.</p>
    </div>

    <div class="card">
      <div class="thumb"><img alt="Double queen"
        src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Hotel_room_double_queen.jpg/1280px-Hotel_room_double_queen.jpg"></div>
      <h3>Double Queen</h3>
      <p>Great for families or friends.</p>
    </div>
  </div>
</section>

<footer class="site-footer">
  <div class="container grid grid-3">
    <div>
      <h4>Reservations Office</h4>
      <div>123 Marina Way, Joviedsa Island WA</div>
      <div>+1 (360) 555-0148</div>
      <div>hello@moffatbay.com</div>
    </div>
    <div>
      <h4>Office Hours</h4>
      <div>Mon–Fri 9:00–18:00 • Sat 9:00–12:00</div>
    </div>
    <div>
      <h4>Get Social</h4>
      <div><a href="#">Instagram</a> • <a href="#">Facebook</a></div>
    </div>
  </div>
</footer>
</body>
</html>
