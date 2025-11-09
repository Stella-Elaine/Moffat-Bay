<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>About the Lodge – Moffat Bay</title>
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
    <h1>About the Lodge</h1>
    <p>Built with cedar and stone, the lodge sits on a quiet curve of Moffat Bay with trail access in both directions.</p>
  </div>
</section>

<section class="container mt-2">
  <div class="grid grid-3">
    <article class="card">
      <div class="thumb">
        <img alt="Lodge exterior"
          src="photos/about-exterior.jpg">
      </div>
      <h3>Warm, relaxed exteriors</h3>
      <p>Cedar siding, low ambient lighting, and native planting create a calm arrival after the ferry.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Quiet room interior"
          src="photos/about-room-view.jpg">
      </div>
      <h3>Rooms designed for quiet stays</h3>
      <p>Soft finishes and blackout curtains keep nights restful; morning light finds the bay.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Boardwalk to marina"
          src="photos/about-marina.jpg">
      </div>
      <h3>Steps from the water</h3>
      <p>From the lobby porch, it’s a short walk to tide pools and the kayak shed.</p>
    </article>
  </div>
</section>

<section class="band">
  <div class="container grid grid-3">
    <div class="card">
      <h3>Check-In / Check-Out</h3>
      <p>Check-in from 3:00 PM • Check-out at 11:00 AM.</p>
    </div>
    <div class="card">
      <h3>Amenities</h3>
      <p>Wi-Fi, streaming-ready TVs, mini-fridge, in-room coffee, and trail maps at the front desk.</p>
    </div>
    <div class="card">
      <h3>Parking & Access</h3>
      <p>Guest parking available at the lodge. The walk to the shoreline outlook is level and lit.</p>
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
