<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="/WEB-INF/includes/header.jsp" />

<section class="container">
  <h1 class="section-title">Moffat Bay Lodge</h1>
  <p>Welcome to Moffat Bay Lodge.</p>
  <img src="<c:url value='/photos/sample.jpg'/>" alt="sample" style="max-width:200px;">
</section>

<script src="<c:url value='/scripts/app.js'/>"></script>
<jsp:include page="/WEB-INF/includes/footer.jsp" />