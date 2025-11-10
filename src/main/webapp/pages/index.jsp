<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %> 

 <jsp:include page="/WEB-INF/includes/header.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">

<section class="hero">
  <div class="inner">
    <h1>Welcome to Your Island Stay</h1>
    <p>Coastal calm, cedar-scented air, and easy access to kayak coves and whale-watching.</p>
    <div class="stack" style="justify-items:center; margin-top:.9rem">
      <a class="btn btn-outline" href="reservation.jsp">Reserve a Room</a>
      <a class="btn btn-outline" href="attractions.jsp">See Attractions</a>
    </div>
  </div>
</section>

<section class="band">
  <div class="container grid grid-3">
    <div class="card">
      <span class="badge">Rooms & Rates</span>
      <h3>Warm lodge rooms with wood finishes</h3>
      <p>Double Full, Queen, Double Queen, and King—straightforward nightly pricing.</p>
      <a class="btn" href="reservation.jsp">Start Booking</a>
    </div>

    <div class="card">
      <span class="badge">Island Activities</span>
      <h3>Trails, kayaks, whales & cold-water diving</h3>
      <p>Explore Moran State Park, sheltered coves, and seasonal wildlife around Moffat Bay.</p>
      <a class="btn" href="attractions.jsp">Explore</a>
    </div>

    <div class="card">
      <span class="badge">Already Booked?</span>
      <h3>Find your reservation</h3>
      <p>Look up using your reservation ID or the email you registered with.</p>
      <a class="btn" href="lookup.jsp">Find Reservation</a>
    </div>
  </div>
</section>

<section class="container mt-3">
  <h2 class="section-title">A Glimpse Around the Lodge</h2>
  <div class="grid grid-3">
    <figure class="card">
      <div class="thumb">
        <img alt="Cedar lodge lounge"
          src="photos/home-cedar-sitting-area.jpg">
      </div>
      <figcaption>Cozy common areas with cedar accents.</figcaption>
    </figure>

    <figure class="card">
      <div class="thumb">
        <img alt="Evergreen path"
          src="photos/home-walking-path.jpg">
      </div>
      <figcaption>Trail access within minutes of the property.</figcaption>
    </figure>

    <figure class="card">
      <div class="thumb">
        <img alt="Sunset road on the island"
          src="photos/home-sunset-view.jpg">
      </div>
      <figcaption>Evening strolls and quiet island roads.</figcaption>
    </figure>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
