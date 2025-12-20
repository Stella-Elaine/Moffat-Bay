<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/includes/header.jsp" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!-- Flash success -->
<c:if test="${not empty sessionScope.flash_success}">
  <section class="container mt-2">
    <div class="alert success">${sessionScope.flash_success}</div>
  </section>
  <c:remove var="flash_success" scope="session"/>
</c:if>

<section class="hero">
  <div class="inner">
    <h1>Make a Reservation</h1>
    <p>Choose your room type, dates, and guests.</p>
  </div>
</section>

<section class="container mt-3">

  <!-- Error message -->
  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <!-- Availability Search -->
  <form class="card" method="post" action="${pageContext.request.contextPath}/reserve">
    <input type="hidden" name="csrf_token" value="${sessionScope.csrfToken}" />
    <input type="hidden" name="action" value="search" />
    <div class="grid grid-3">
      <div>
        <label for="check_in">Check In Date</label>
        <input id="check_in" name="check_in" type="date"
               value="${check_in != null ? check_in : param.check_in}" required />
      </div>

      <div>
        <label for="check_out">Check Out Date</label>
        <input id="check_out" name="check_out" type="date"
               value="${check_out != null ? check_out : param.check_out}" required />
      </div>

      <div>
        <label for="guests">Guests</label>
        <select id="guests" name="guests">
          <option value="1" ${(guests == 1 || param.guests == '1') ? 'selected' : ''}>1</option>
          <option value="2" ${(guests == 2 || param.guests == '2') ? 'selected' : ''}>2</option>
          <option value="3" ${(guests == 3 || param.guests == '3') ? 'selected' : ''}>3</option>
          <option value="4" ${(guests == 4 || param.guests == '4') ? 'selected' : ''}>4</option>
        </select>
      </div>
    </div>

    <div class="grid grid-2 mt-3" style="align-items: flex-end;">
      <div>
        <label for="room">Room Selection</label>
        <select id="room" name="room_type_id">
          <option value="1" ${(preferred_room_type_id == 1 || param.room_type_id == '1') ? 'selected' : ''}>Double Full</option>
          <option value="2" ${(preferred_room_type_id == 2 || param.room_type_id == '2') ? 'selected' : ''}>Queen</option>
          <option value="3" ${(preferred_room_type_id == 3 || param.room_type_id == '3') ? 'selected' : ''}>Double Queen</option>
          <option value="4" ${(preferred_room_type_id == 4 || param.room_type_id == '4') ? 'selected' : ''}>King</option>
        </select>
      </div>

      <div style="display: flex; justify-content: flex-end;">
        <button type="submit" class="btn">Search Availability</button>
      </div>
    </div>
  </form>

  <c:if test="${not empty availableRooms}">
    <h2 class="section-title">Available Rooms</h2>

    <form class="card" method="post" action="${pageContext.request.contextPath}/reserve">
      <input type="hidden" name="csrf_token" value="${sessionScope.csrfToken}" />
      <input type="hidden" name="action" value="reserve"/>
      <input type="hidden" name="check_in" value="${check_in}"/>
      <input type="hidden" name="check_out" value="${check_out}"/>
      <input type="hidden" name="guests" value="${guests}"/>
      <input type="hidden" name="room_type_id" value="${preferred_room_type_id}"/>

      <fieldset class="room-list-scroll">
        <legend>Select a room</legend>

        <c:forEach var="opt" items="${availableRooms}">
          <label class="card">
            <div class="thumb">
              <c:set var="prefix" value="DF"/>
              <c:if test="${fn:startsWith(opt.roomNumber,'DQ')}"><c:set var="prefix" value="DQ"/></c:if>
              <c:if test="${fn.startsWith(opt.roomNumber,'DF')}"><c:set var="prefix" value="DF"/></c:if>
              <c:if test="${fn:startsWith(opt.roomNumber,'Q')}"><c:set var="prefix" value="Q"/></c:if>
              <c:if test="${fn:startsWith(opt.roomNumber,'K')}"><c:set var="prefix" value="K"/></c:if>

              <c:set var="fileName" value="room-option-${prefix}.jpg"/>
              <img alt="${opt.roomTypeName}" src="<c:url value='/photos/rooms/${fileName}'/>"/>
            </div>

            <div style="padding: 0.75rem 0;">
              <div style="margin-bottom: 0.5rem;">
                <input type="radio" name="room_choice"
                       value="${opt.roomId}:${opt.roomTypeId}" required />
                <strong>Room ${opt.roomNumber}</strong>
              </div>
              <div>${opt.roomTypeName} • Max ${opt.maxGuests} guests • $${opt.nightlyRate}/night</div>
            </div>
          </label>
        </c:forEach>

      </fieldset>

      <div class="mt-2">
        <button type="submit" class="btn">Reserve Selected Room</button>
      </div>
    </form>

  </c:if>
</section>

<script>
  window.addEventListener("DOMContentLoaded", () => {
    const flash = document.querySelector(".alert.success");
    if (flash) {
      setTimeout(() => {
        flash.style.transition = "opacity .8s ease";
        flash.style.opacity = "0";
      }, 4000);
    }
  });
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>