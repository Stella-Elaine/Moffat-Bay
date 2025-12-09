<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="/WEB-INF/includes/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/stylesheets/reservation-summary.css' />">

<section class="container reservation-summary-page">
  <h1 class="section-title">Reservation Confirmation</h1>

  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <c:if test="${not empty summary}">
    <div class="summary-wrapper">
      
      <div class="summary-header">
        <div class="confirmation-badge">
          <h2>Booking ${summary.status == 'Cancelled' ? 'Cancelled' : 'Confirmed'}</h2>
          <p class="ref-number">Reference #${summary.reservationId}</p>
        </div>
      </div>

      <div class="summary-grid">
        <div class="room-preview card">
          <div class="thumb">
            <c:set var="firstRoom" value="${summary.roomNumbers[0]}"/>
            <c:set var="prefix" value="DF"/>
            <c:if test="${fn:startsWith(firstRoom,'DQ')}"><c:set var="prefix" value="DQ"/></c:if>
            <c:if test="${fn.startsWith(firstRoom,'DF')}"><c:set var="prefix" value="DF"/></c:if>
            <c:if test="${fn:startsWith(firstRoom,'Q')}"><c:set var="prefix" value="Q"/></c:if>
            <c:if test="${fn:startsWith(firstRoom,'K')}"><c:set var="prefix" value="K"/></c:if>
            <c:set var="fileName" value="room-option-${prefix}.jpg"/>
            <img alt="${summary.roomTypeName}" src="<c:url value='/photos/rooms/${fileName}'/>">
          </div>
          <div class="room-info">
            <h3>${summary.roomTypeName}</h3>
            <p class="room-numbers">
              Room <c:forEach var="rn" items="${summary.roomNumbers}" varStatus="s">${rn}<c:if test="${!s.last}">, </c:if></c:forEach>
            </p>
          </div>
        </div>

        <div class="booking-details card">
          <h3>Booking Details</h3>
          <div class="detail-row">
            <span class="label">Guest Name</span>
            <span class="value">${summary.customerFirstName} ${summary.customerLastName}</span>
          </div>
          <div class="detail-row">
            <span class="label">Email</span>
            <span class="value">${summary.customerEmail}</span>
          </div>
          <div class="detail-row">
            <span class="label">Check-In</span>
            <span class="value">
              <%
                model.ReservationSummary sum = (model.ReservationSummary) request.getAttribute("summary");
                if (sum != null && sum.getCheckIn() != null) {
                  out.print(sum.getCheckIn().format(java.time.format.DateTimeFormatter.ofPattern("MM/dd/yyyy")));
                }
              %>
            </span>
          </div>
          <div class="detail-row">
            <span class="label">Check-Out</span>
            <span class="value">
              <%
                if (sum != null && sum.getCheckOut() != null) {
                  out.print(sum.getCheckOut().format(java.time.format.DateTimeFormatter.ofPattern("MM/dd/yyyy")));
                }
              %>
            </span>
          </div>
          <div class="detail-row">
            <span class="label">Duration</span>
            <span class="value">
              <%
                try {
                  if (sum != null && sum.getCheckIn() != null && sum.getCheckOut() != null) {
                    long nights = java.time.temporal.ChronoUnit.DAYS.between(sum.getCheckIn(), sum.getCheckOut());
                    out.print(nights + (nights == 1 ? " night" : " nights"));
                  } else { out.print("N/A"); }
                } catch (Exception e) { out.print("N/A"); }
              %>
            </span>
          </div>
          <div class="detail-row">
            <span class="label">Guests</span>
            <span class="value">${summary.numGuests} ${summary.numGuests == 1 ? 'guest' : 'guests'}</span>
          </div>
          <div class="detail-row total">
            <span class="label">Total Cost</span>
            <span class="value price">$<fmt:formatNumber value="${summary.totalCost}" type="number" minFractionDigits="2"/></span>
          </div>
          <c:if test="${summary.status == 'Cancelled'}">
            <div class="status-banner cancelled">
              <strong>CANCELLED</strong>
            </div>
          </c:if>
        </div>
      </div>

      <div class="action-buttons">
        <c:if test="${summary.status != 'Cancelled'}">
          <form method="post" action="${pageContext.request.contextPath}/reservation-cancel" class="cancel-form">
            <input type="hidden" name="csrf_token" value="${sessionScope.csrfToken}" />
            <input type="hidden" name="id" value="${summary.reservationId}"/>
            <button class="btn btn-secondary" type="submit">Cancel Booking</button>
          </form>
        </c:if>
        <a class="btn btn-primary" href="<c:url value='/pages/index.jsp'/>">Return to Home</a>
      </div>

    </div>
  </c:if>
</section>

<div id="cancelModal" aria-hidden="true">
  <div id="cancelBackdrop"></div>
  <div id="cancelContent">
    <h2>Reservation cancelled</h2>
    <p id="cancelMessage">Your reservation has been cancelled.</p>
    <div style="text-align:right;">
      <button id="closeCancel">OK</button>
    </div>
  </div>
</div>

<script>
(function() {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initModal);
  } else {
    initModal();
  }

  function initModal() {
    const params = new URLSearchParams(window.location.search);
    const status = params.get('status');
    const id = params.get('id');

    if (status === 'cancelled') {
      const modal = document.getElementById('cancelModal');
      const message = document.getElementById('cancelMessage');

      if (id) {
        message.textContent = 'Your reservation #' + id + ' has been cancelled.';
      }

      modal.style.display = 'block';
      modal.setAttribute('aria-hidden', 'false');

      const close = () => {
        modal.style.display = 'none';
        modal.setAttribute('aria-hidden', 'true');

        params.delete('status');
        const newQuery = params.toString();
        const newUrl = location.pathname + (newQuery ? '?' + newQuery : '');
        window.location.href = newUrl;
      };

      document.getElementById('closeCancel').addEventListener('click', close);
      document.getElementById('cancelBackdrop').addEventListener('click', close);
      document.addEventListener('keydown', e => { if (e.key === 'Escape') close(); });
    }
  }

  document.readyState === "loading"
    ? document.addEventListener("DOMContentLoaded", init)
    : init();
})();
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>