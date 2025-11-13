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
          <dt>Guests:</dt><dd>${summary.numGuests}</dd>
          <dt>Room number(s):</dt>
          <dd>
            <c:forEach var="rn" items="${summary.roomNumbers}" varStatus="s">
              ${rn}<c:if test="${!s.last}">, </c:if>
            </c:forEach>
          </dd>
          <dt>Total:</dt><dd>$<fmt:formatNumber value="${summary.totalCost}" type="number" minFractionDigits="2"/></dd>
          <dt>Status:</dt><dd>${summary.status}</dd>
        </dl>

        <div class="mt-2 stack" style="grid-auto-flow:row; grid-template-columns:none">
          <form method="post" action="${pageContext.request.contextPath}/reservation-cancel" style="display:inline">
            <input type="hidden" name="id" value="${summary.reservationId}"/>
            <button class="btn" type="submit" ${summary.status == 'Cancelled' ? 'disabled' : ''}>Cancel Booking</button>
          </form>
          <a class="btn" href="<c:url value='/pages/index.jsp'/>">Return to Home</a>
        </div>
      </div>
    </div>
  </c:if>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

