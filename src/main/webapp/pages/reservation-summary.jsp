<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ include file="/WEB-INF/includes/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">

<section class="container">
  <h1 class="section-title">Reservation Summary</h1>

  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <c:if test="${not empty summary}">
    <div class="grid grid-2">
      <figure class="card">
        <div class="thumb">
          <c:set var="firstRoom" value="${summary.roomNumbers[0]}"/>
          <c:set var="prefix" value="DF"/>
          <c:if test="${fn:startsWith(firstRoom,'DQ')}"><c:set var="prefix" value="DQ"/></c:if>
          <c:if test="${fn:startsWith(firstRoom,'DF')}"><c:set var="prefix" value="DF"/></c:if>
          <c:if test="${fn:startsWith(firstRoom,'Q')}"><c:set var="prefix" value="Q"/></c:if>
          <c:if test="${fn:startsWith(firstRoom,'K')}"><c:set var="prefix" value="K"/></c:if>
          <c:set var="fileName" value="room-option-${prefix}.jpg"/>
          <img alt="${summary.roomTypeName}" src="<c:url value='/photos/rooms/${fileName}'/>">
        </div>
        <figcaption>${summary.roomTypeName}</figcaption>
      </figure>

      <div class="summary card">
        <dl>
          <dt>Reference number:</dt><dd>${summary.reservationId}</dd>
          <dt>Customer:</dt><dd>${summary.customerFirstName} ${summary.customerLastName} (${summary.customerEmail})</dd>
          <dt>Check-in date:</dt><dd>${summary.checkIn}</dd>
          <dt>Check-out date:</dt><dd>${summary.checkOut}</dd>
          <dt>Number of nights:</dt><dd>
            <%
              try {
                model.ReservationSummary sum = (model.ReservationSummary) request.getAttribute("summary");
                if (sum != null && sum.getCheckIn() != null && sum.getCheckOut() != null) {
                  long nights = java.time.temporal.ChronoUnit.DAYS.between(sum.getCheckIn(), sum.getCheckOut());
                  out.print(nights + (nights == 1 ? " night" : " nights"));
                } else {
                  out.print("N/A");
                }
              } catch (Exception e) {
                out.print("N/A");
              }
            %>
          </dd>
          <dt>Guests:</dt><dd>${summary.numGuests}</dd>
          <dt>Room number(s):</dt>
          <dd>
            <c:forEach var="rn" items="${summary.roomNumbers}" varStatus="s">
              ${rn}<c:if test="${!s.last}">, </c:if>
            </c:forEach>
          </dd>
          <dt>Total:</dt><dd>$<fmt:formatNumber value="${summary.totalCost}" type="number" minFractionDigits="2"/></dd>
          <dt>Status:</dt><dd><span class="${summary.status == 'Cancelled' ? 'status-cancelled' : ''}">${summary.status == 'Cancelled' ? 'CANCELLED' : summary.status}</span></dd>
        </dl>

        <div class="mt-2 stack" style="grid-auto-flow:row; grid-template-columns:none">
          <c:if test="${summary.status != 'Cancelled'}">
            <form method="post" action="${pageContext.request.contextPath}/reservation-cancel" style="display:inline">
              <input type="hidden" name="id" value="${summary.reservationId}"/>
              <button class="btn" type="submit">Cancel Booking</button>
            </form>
          </c:if>
          <a class="btn" href="<c:url value='/pages/index.jsp'/>">Return to Home</a>
        </div>
      </div>
    </div>
  </c:if>
</section>

<style>
  #cancelModal { display:none; position:fixed; inset:0; z-index:1000; }
  #cancelBackdrop { position:fixed; inset:0; background:rgba(0,0,0,.5); }
  #cancelContent {
    position:fixed; left:50%; top:50%; transform:translate(-50%,-50%);
    background:#fff; padding:20px; border-radius:8px; max-width:90%; width:360px;
    box-shadow:0 8px 24px rgba(0,0,0,.2);
  }
  #cancelContent h2 { margin:0 0 8px; font-size:1.1rem; }
  #cancelContent p { margin:0 0 16px; }
  #closeCancel { padding:8px 14px; }
  .status-cancelled { color: #dc3545; font-weight: bold; }
</style>

<div id="cancelModal" aria-hidden="true">
  <div id="cancelBackdrop"></div>
  <div id="cancelContent" role="dialog" aria-modal="true" aria-labelledby="cancelTitle">
    <h2 id="cancelTitle">Reservation cancelled</h2>
    <p id="cancelMessage">Your reservation has been cancelled.</p>
    <div style="text-align:right;">
      <button id="closeCancel" type="button">OK</button>
    </div>
  </div>
</div>

<script>
(function() {
  // Wait for DOM to be fully loaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initModal);
  } else {
    initModal();
  }
  
  function initModal() {
    console.log('Initializing cancel modal...');
    console.log('Current URL:', window.location.href);
    console.log('Search params:', window.location.search);
    
    const params = new URLSearchParams(window.location.search);
    const status = params.get('status');
    const id = params.get('id');
    
    console.log('Status param:', status);
    console.log('ID param:', id);
    
    if (status === 'cancelled') {
      console.log('Cancelled status detected, showing modal...');
      
      const modal = document.getElementById('cancelModal');
      const message = document.getElementById('cancelMessage');
      
      if (!modal) {
        console.error('Modal element not found!');
        return;
      }
      
      if (id) {
        message.textContent = 'Your reservation #' + id + ' has been cancelled.';
      }
      
      modal.style.display = 'block';
      modal.setAttribute('aria-hidden', 'false');
      console.log('Modal should now be visible');

    const close = function() {
      console.log('Closing modal...');
      modal.style.display = 'none';
      modal.setAttribute('aria-hidden', 'true');
      // Remove status parameter and reload page to show updated summary
      params.delete('status');
      const newQuery = params.toString();
      const newUrl = location.pathname + (newQuery ? '?' + newQuery : '');
      window.location.href = newUrl;
    };      document.getElementById('closeCancel').addEventListener('click', close);
      document.getElementById('cancelBackdrop').addEventListener('click', close);
      document.addEventListener('keydown', function(e) { 
        if (e.key === 'Escape') close(); 
      });
    } else {
      console.log('No cancelled status found in URL');
    }
  }
})();
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

