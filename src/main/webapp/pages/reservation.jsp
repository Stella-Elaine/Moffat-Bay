<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<!-- flash message of  success from LoginServlet / RegisterServlet -->
<c:if test="${not empty sessionScope.flash_success}">
  <section class="container mt-2">
    <div class="alert success">
      ${sessionScope.flash_success}
    </div>
  </section>
  <c:remove var="flash_success" scope="session" />
</c:if>

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
          <option>1</option>
          <option>2</option>
          <option>3</option>
          <option>4</option>
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
      <div></div>
      <div></div>
    </div>

    <a class="btn mt-2" href="reservation-summary.jsp">Search Availability</a>
  </form>

  <h2 class="section-title">Room Options (Preview)</h2>
  <div class="grid grid-3">
    <div class="card">
      <div class="thumb">
        <img alt="Double full"
             src="<c:url value='/photos/attractions-kayaking.jpg' />">
      </div>
      <h3>Double Full</h3>
      <p>Cozy option for compact stays.</p>
    </div>

    <div class="card">
      <div class="thumb">
        <img alt="Queen"
             src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Hotel_room_queen_bed.jpg/1280px-Hotel_room_queen_bed.jpg">
      </div>
      <h3>Queen</h3>
      <p>Balanced space and comfort.</p>
    </div>

    <div class="card">
      <div class="thumb">
        <img alt="Double queen"
             src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Hotel_room_double_queen.jpg/1280px-Hotel_room_double_queen.jpg">
      </div>
      <h3>Double Queen</h3>
      <p>Great for families or friends.</p>
    </div>
  </div>
</section>

<script>
  // fade out success flash after a few seconds
  window.addEventListener("DOMContentLoaded", () => {
    const flash = document.querySelector(".alert.success");
    if (flash) {
      setTimeout(() => {
        flash.style.transition = "opacity 0.8s ease";
        flash.style.opacity = "0";
      }, 4000); // this is  4 seconds
    }
  });
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
