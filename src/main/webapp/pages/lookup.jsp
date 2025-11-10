<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

 <jsp:include page="/WEB-INF/includes/header.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">

<section class="container">
  <h1 class="section-title">Look Up a Reservation</h1>
  <form class="card" action="#" method="get" onsubmit="return false;">
    <label for="rid">Reservation ID</label>
    <input id="rid" type="text" placeholder="e.g., MB-2025-123456" />
    <label for="remail" class="mt-2">Email used for booking</label>
    <input id="remail" type="email" placeholder="you@example.com" />
    <button class="btn mt-2" type="submit">Find Reservation</button>
  </form>
</section>
<%@ include file="/WEB-INF/includes/footer.jsp" %>

