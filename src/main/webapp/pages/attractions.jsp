<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/includes/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">

<section class="container">
  <h1 class="section-title">Promos and Attractions</h1>
  <p style="max-width: 720px; margin-bottom: 1.75rem; color:#5b4031;">
    Experience the best of Moffat Bay — from ocean adventures to relaxing escapes.
    All activities are curated to help guests enjoy the natural beauty of the islands.
  </p>

  <div class="grid grid-3">

    <article class="card attraction-card">
      <div class="thumb">
        <img
          alt="Kayaking"
          loading="lazy"
          src="<c:url value='/photos/attractions-kayaking.jpg' />">
      </div>
      <h3>Kayaking</h3>
      <p>Spots are limited—schedule a calm-water paddle across protected coves.</p>
    </article>

    <article class="card attraction-card">
      <div class="thumb">
        <img
          alt="Whale Watching"
          loading="lazy"
          src="<c:url value='/photos/attractions-whales.jpg' />">
      </div>
      <h3>Whale Watching</h3>
      <p>Seasonal orca and humpback sightings—book a family-friendly tour.</p>
    </article>

    <article class="card attraction-card">
      <div class="thumb">
        <img
          alt="Nature Hike"
          loading="lazy"
          src="<c:url value='/photos/attractions-nature-hike.jpg' />">
      </div>
      <h3>Hiking In Nature</h3>
      <p>Moran State Park features lakeside loops and panoramic lookouts.</p>
    </article>

    <article class="card attraction-card">
      <div class="thumb">
        <img
          alt="Scuba Diving"
          loading="lazy"
          src="<c:url value='/photos/attractions-scuba.jpg' />">
      </div>
      <h3>Scuba Dive</h3>
      <p>Guided cold-water dives with trained divemasters and local reef briefings.</p>
    </article>

    <article class="card attraction-card">
      <div class="thumb">
        <img
          alt="Spa"
          loading="lazy"
          src="<c:url value='/photos/attractions-spa.jpg' />">
      </div>
      <h3>Grand Members Club</h3>
      <p>Return guests receive discounts on future bookings and spa access.</p>
    </article>

    <article class="card attraction-card">
      <div class="thumb">
        <img
          alt="Dining"
          loading="lazy"
          src="<c:url value='/photos/attractions-dining.jpg' />">
      </div>
      <h3>Island Dining</h3>
      <p>Casual coastal fare, farm-to-table spots, and cabana service in season.</p>
    </article>

  </div>
</section>

<section class="band">
  <div class="container" style="text-align:center;">
    <h2 style="font-family:Georgia,serif; margin-bottom:0.75rem;">Plan Your Adventure</h2>
    <p style="margin-bottom:1.25rem;">Reserve your stay and experience all Moffat Bay has to offer.</p>
    <a href="<c:url value='/pages/register.jsp'/>" class="btn">Book Your Stay</a>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>