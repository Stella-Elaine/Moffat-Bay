<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/includes/header.jsp" %>
<section class="container">
  <h1 class="section-title">Look Up a Reservation</h1>

  <form class="card" action="<c:url value='/lookup'/>" method="get">
    <div class="grid grid-2">
      <div>
        <label for="resid">Reservation ID</label>
        <input id="resid" name="reservation_id" type="number" min="1" />
      </div>
      <div>
        <label for="email">Email</label>
        <input id="email" name="email" type="email" />
      </div>
    </div>
    <button class="btn mt-2" type="submit">Search</button>
  </form>
</section>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
