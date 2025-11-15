<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/includes/header.jsp" %>
<section class="container">
  <h1 class="section-title">Look Up a Reservation</h1>

  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <form class="card" action="<c:url value='/lookup'/>" method="get">
    <div class="grid grid-2">
      <div>
        <label for="resid">Reservation ID</label>
        <input id="resid" name="reservation_id" type="number" min="1" />
      </div>
      <div>
        <label for="email">Email</label>
        <input id="email" name="email" type="email" value="${email}" />
      </div>
    </div>
    <button class="btn mt-2" type="submit">Search</button>
  </form>

  <c:if test="${not empty results}">
    <h2 class="section-title">Reservations for ${email}</h2>
    <div class="card" style="overflow-x:auto;">
      <table class="table" style="width:100%; border-collapse:collapse;">
        <thead>
          <tr>
            <th style="text-align:left;">ID</th>
            <th style="text-align:left;">Check-In</th>
            <th style="text-align:left;">Check-Out</th>
            <th style="text-align:left;">Status</th>
            <th style="text-align:left;">Total</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="r" items="${results}">
            <tr>
              <td>${r.reservationId}</td>
              <td>${r.checkIn}</td>
              <td>${r.checkOut}</td>
              <td>${r.status}</td>
              <td>$${r.totalCost}</td>
              <td><a class="btn" href="<c:url value='/reservation-summary?id=${r.reservationId}'/>">View</a></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>
</section>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
