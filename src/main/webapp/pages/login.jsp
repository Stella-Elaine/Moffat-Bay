<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="/WEB-INF/includes/header.jsp" />
<section class="container">
  <h1 class="section-title">Log In</h1>

  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <form class="card" action="<c:url value='/login'/>" method="post">
    <label for="email">Email</label>
    <input id="email" name="email" type="email" required />
    <label for="pw">Password</label>
    <input id="pw" name="password" type="password" required />
    <button class="btn mt-2" type="submit">Log In</button>
  </form>
</section>
<jsp:include page="/WEB-INF/includes/footer.jsp" />
