<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<section class="container lookup-page">
  <h1 class="section-title">Look Up a Reservation</h1>
  <p class="helper-text">
    Search using the email you registered with. You can add a Reservation ID if you know it.
  </p>

  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <!-- Search form -->
  <form class="card lookup-form" action="<c:url value='/lookup'/>" method="get">
    <div class="grid grid-2">
      <div class="field">
        <label for="resid">Reservation ID</label>
        <input
          id="resid"
          name="reservation_id"
          type="number"
          min="1"
        />
        <p class="field-hint">
          Optional — leave blank to see all reservations for this email.
        </p>
      </div>

      <div class="field">
        <label for="email">Email</label>
        <input
          id="email"
          name="email"
          type="email"
          value="${email}"
        />
      </div>
    </div>

    <button class="btn mt-2" type="submit">Search</button>
  </form>

  <!-- Results table -->
  <c:if test="${not empty results}">
    <h2 class="section-title section-title-sm">Reservations for ${email}</h2>

    <div class="card table-wrapper">
      <table class="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Check-In</th>
            <th>Check-Out</th>
            <th>Status</th>
            <th>Total</th>
            <th class="actions-col"></th>
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
              <td class="actions-col">
                <a class="btn btn-small"
                   href="<c:url value='/reservation-summary?id=${r.reservationId}'/>">
                  View
                </a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>