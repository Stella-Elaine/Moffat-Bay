<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/includes/header.jsp" %>

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
             src="<c:url value='/photos/about-exterior.jpg' />">
      </div>
      <h3>Warm, relaxed exteriors</h3>
      <p>Cedar siding, low ambient lighting, and native planting create a calm arrival after the ferry.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Quiet room interior"
             src="<c:url value='/photos/about-room-view.jpg' />">
      </div>
      <h3>Rooms designed for quiet stays</h3>
      <p>Soft finishes and blackout curtains keep nights restful; morning light finds the bay.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Boardwalk to marina"
             src="<c:url value='/photos/about-marina.jpg' />">
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
      <p>Wi-Fi, streaming TVs, mini-fridge, in-room coffee, and trail maps at the front desk.</p>
    </div>
    <div class="card">
      <h3>Parking & Access</h3>
      <p>Guest parking available at the lodge. The walk to the shoreline outlook is level and lit.</p>
    </div>
  </div>
</section>

<section class="container mt-3" id="contact">
  <h1>Contact Us</h1>
  <div class="grid grid-3">
    <div class="card">
      <h2>Reservations Office</h2>
      <p>123 Marina Way, Joviedsa Island WA<br>+1 (360) 555-0148<br>hello@moffatbay.com</p>
    </div>
    <div class="card">
      <h2>Office Hours</h2>
      <p>Mon–Fri 9:00–18:00 • Sat 9:00–12:00</p>
    </div>
    <div class="card">
      <h2>Social</h2>
      <p>
        <a class="social-link" href="#" aria-label="Instagram">
          <img class="icon-sm" src="<c:url value='/photos/instagram-logo.png' />" alt="Instagram logo" />
          <span>Instagram</span>
        </a>
        •
        <a class="social-link" href="#" aria-label="Facebook">
          <img class="icon-sm" src="<c:url value='/photos/facebook-logo.png' />" alt="Facebook logo" />
          <span>Facebook</span>
        </a>
      </p>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
