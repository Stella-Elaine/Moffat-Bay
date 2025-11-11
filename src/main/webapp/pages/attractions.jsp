<%@ page contentType="text/html; charset=UTF-8" language="java" %>

 <jsp:include page="/WEB-INF/includes/header.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">

<section class="container">
  <h1 class="section-title">Promos and Attractions</h1>

  <div class="grid grid-3">
    <article class="card">
      <div class="thumb">
       <img alt="Kayaking"       
       src="<c:url value='/photos/attractions-kayaking.jpg' />">

      </div>
      <h3>Kayaking</h3>
      <p>Spots are limited—schedule a calm-water paddle across protected coves.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Whale Watching" 
        src="<c:url value='/photos/attractions-whales.jpg' />">
      </div>
      <h3>Whale Watching</h3>
      <p>Seasonal orca and humpback sightings—book a family-friendly tour.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Hiking"         
        src="<c:url value='/photos/attractions-nature-hike.jpg' />">
      </div>
      <h3>Hiking In Nature</h3>
      <p>Moran State Park features lakeside loops and panoramic lookouts.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Scuba"          
        src="<c:url value='/photos/attractions-scuba.jpg' />">
      </div>
      <h3>Scuba Dive</h3>
      <p>Guided cold-water dives with trained divemasters and local reef briefings.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Spa"            
        src="<c:url value='/photos/attractions-spa.jpg' />">
      </div>
      <h3>Grand Members Club</h3>
      <p>Return guests receive discounts on future bookings and spa access.</p>
    </article>

    <article class="card">
      <div class="thumb">
        <img alt="Dining"         
        src="<c:url value='/photos/attractions-dining.jpg' />">
      </div>
      <h3>Island Dining</h3>
      <p>Casual coastal fare, farm-to-table spots, and cabana service in season.</p>
    </article>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
