<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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
  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>
  <!-- Step 1: Search availability -->
  <form class="card" method="post" action="${pageContext.request.contextPath}/reserve">
    <div class="grid grid-3">
      <div>
        <label for="in">Check In Date</label>
        <input id="in" name="check_in" type="date" value="${check_in != null ? check_in : param.check_in}" required />
      </div>
      <div>
        <label for="out">Check Out Date</label>
        <input id="out" name="check_out" type="date" value="${check_out != null ? check_out : param.check_out}" required />
      </div>
      <div>
        <label for="guests">Guests</label>
        <select id="guests" name="guests">
          <option value="1" ${ (guests == 1 || param.guests == '1') ? 'selected' : ''}>1</option>
          <option value="2" ${ (guests == 2 || param.guests == '2') ? 'selected' : ''}>2</option>
          <option value="3" ${ (guests == 3 || param.guests == '3') ? 'selected' : ''}>3</option>
          <option value="4" ${ (guests == 4 || param.guests == '4') ? 'selected' : ''}>4</option>
        </select>
      </div>
    </div>

    <div class="grid grid-3 mt-2">
      <div>
        <label for="room">Room Selection</label>
        <select id="room" name="room_type_id">
          <option value="1" ${ (preferred_room_type_id == 1 || param.room_type_id == '1') ? 'selected' : ''}>Double Full</option>
          <option value="2" ${ (preferred_room_type_id == 2 || param.room_type_id == '2') ? 'selected' : ''}>Queen</option>
          <option value="3" ${ (preferred_room_type_id == 3 || param.room_type_id == '3') ? 'selected' : ''}>Double Queen</option>
          <option value="4" ${ (preferred_room_type_id == 4 || param.room_type_id == '4') ? 'selected' : ''}>King</option>
        </select>
      </div>
      <div></div>
      <div></div>
    </div>
    <input type="hidden" name="action" value="search"/>
    <div class="mt-2"><button type="submit" class="btn">Search Availability</button></div>
  </form>

  <!-- Step 2: Show available options and prompt to select -->
  <c:if test="${not empty availableRooms}">
    <h2 class="section-title">Available Rooms</h2>
    <form class="card" method="post" action="${pageContext.request.contextPath}/reserve">
      <input type="hidden" name="action" value="reserve"/>
      <!-- keep the search context -->
      <input type="hidden" name="check_in" value="${check_in}"/>
      <input type="hidden" name="check_out" value="${check_out}"/>
      <input type="hidden" name="guests" value="${guests}"/>
      <input type="hidden" name="room_type_id" value="${preferred_room_type_id}"/>
      <!-- Scrollable list so the reserve button stays visible below -->
      <div class="room-list-scroll" style="max-height: 22rem; overflow-y: auto; padding: 0.5rem; border: 1px solid #ddd; border-radius: 6px;">
        <fieldset class="stack" style="border: none; margin: 0; padding: 0;">
          <legend>Select a room</legend>
          <c:forEach var="opt" items="${availableRooms}">
            <label class="card" style="display:grid; grid-template-columns:180px 1fr; gap:1rem; align-items:center; margin-bottom:0.5rem;">
              <div class="thumb">
                <!-- Determine prefix DF/DQ/Q/K from room number -->
                <c:set var="prefix" value="DF"/>
                <c:if test="${fn:startsWith(opt.roomNumber,'DQ')}"><c:set var="prefix" value="DQ"/></c:if>
                <c:if test="${fn:startsWith(opt.roomNumber,'DF')}"><c:set var="prefix" value="DF"/></c:if>
                <c:if test="${fn:startsWith(opt.roomNumber,'Q')}"><c:set var="prefix" value="Q"/></c:if>
                <c:if test="${fn:startsWith(opt.roomNumber,'K')}"><c:set var="prefix" value="K"/></c:if>
                <c:set var="fileName" value="room-option-${prefix}.jpg"/>
                <img alt="${opt.roomTypeName}" src="<c:url value='/photos/rooms/${fileName}'/>"/>
              </div>
              <div>
                <div class="stack" style="gap:0.25rem; align-items:flex-start;">
                  <div>
                    <input type="radio" name="room_choice" value="${opt.roomId}:${opt.roomTypeId}" required />
                    <strong>Room ${opt.roomNumber}</strong>
                  </div>
                  <div>${opt.roomTypeName} • Max ${opt.maxGuests} guests • $${opt.nightlyRate}/night</div>
                </div>
              </div>
            </label>
          </c:forEach>
        </fieldset>
      </div>
      <div class="mt-2">
        <button type="submit" class="btn">Reserve Selected Room</button>
      </div>
    </form>
  </c:if>
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
