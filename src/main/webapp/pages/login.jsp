<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="/WEB-INF/includes/header.jsp" %>
<section class="container">
  <h1 class="section-title">Log In</h1>
  <form class="card" action="#" method="post" onsubmit="return false;">
    <label for="user">Email</label>
    <input id="user" type="email" required />
    <label for="pass" class="mt-2">Password</label>
    <input id="pass" type="password" required />
    <button class="btn mt-2" type="submit">Login</button>
  </form>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>