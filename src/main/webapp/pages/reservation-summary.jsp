<%@ page contentType="text/html; charset=UTF-8" language="java" %>

 <%@ include file="/WEB-INF/includes/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">


<section class="container">
  <h1 class="section-title">Reservation Summary</h1>

  <div class="grid grid-2">
    <figure class="card">
      <div class="thumb">
        <img alt="Booked room"
          src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Hotel_room_warm.jpg/1280px-Hotel_room_warm.jpg">
      </div>
      <figcaption>Double Queen Room</figcaption>
    </figure>

    <div class="summary card">
      <dl>
        <dt>Reference number:</dt><dd>123456789</dd>
        <dt>Customer:</dt><dd>Julio (julioedmead@gmail.com)</dd>
        <dt>Check-in date:</dt><dd>October 27, 2025</dd>
        <dt>Check-out date:</dt><dd>November 1, 2025</dd>
        <dt>Guests:</dt><dd>2 adults, 1 child</dd>
        <dt>Room:</dt><dd>Double Queen Bed Room</dd>
        <dt>Total:</dt><dd>$900.00 for stay</dd>
      </dl>

      <div class="mt-2 stack" style="grid-auto-flow:row; grid-template-columns:none">
        <a class="btn" href="reserve.jsp">Reserve!</a>
        <a class="btn" href="reservation.jsp">Cancel Booking</a>
        <a class="btn" href="index.jsp">Return to Home</a>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

