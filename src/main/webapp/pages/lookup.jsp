<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Reservation Lookup – Moffat Bay Lodge</title>
  <link rel="stylesheet" href="stylesheets/styles.css" />
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

<section class="container">
  <h1 class="section-title">Look Up a Reservation</h1>
  <form class="card" action="#" method="get" onsubmit="return false;">
    <label for="rid">Reservation ID</label>
    <input id="rid" type="text" placeholder="e.g., MB-2025-123456" />
    <label for="remail" class="mt-2">Email used for booking</label>
    <input id="remail" type="email" placeholder="you@example.com" />
    <button class="btn mt-2" type="submit">Find Reservation</button>
  </form>
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
