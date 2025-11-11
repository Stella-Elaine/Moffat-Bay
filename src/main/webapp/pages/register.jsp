
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/includes/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">

<section class="container">
  <h1 class="section-title">Create Your Account</h1>

  <!-- error message from RegisterServlet -->
  <c:if test="${not empty error}">
    <div class="alert error">${error}</div>
  </c:if>

  <!--the  form -->
  <form class="card" action="<c:url value='/register'/>" method="post" novalidate>
    <div class="grid grid-2">
      <div>
        <label for="first">First Name</label>
        <input id="first" name="first_name" type="text" autocomplete="given-name" required />
      </div>
      <div>
        <label for="last">Last Name</label>
        <input id="last" name="last_name" type="text" autocomplete="family-name" required />
      </div>
    </div>

    <div class="grid grid-2 mt-2">
      <div>
        <label for="email">Email (used as username)</label>
        <input id="email" name="email" type="email" placeholder="you@example.com"
               autocomplete="email" required />
      </div>
      <div>
        <label for="phone">Telephone</label>
        <input id="phone" name="telephone" type="tel" placeholder="(360) 555-0148"
               autocomplete="tel" />
      </div>
    </div>

    <!-- the password requirements : ≥8 chars, 1 number, 1 upper, 1 lower -->
    <div class="mt-2">
      <label for="pw">Password</label>
      <input id="pw" name="password" type="password"
             pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}"
             minlength="8"
             title="Min 8 characters, including 1 number, 1 uppercase and 1 lowercase letter"
             autocomplete="new-password"
             required />
    </div>

    <button class="btn mt-2" type="submit">Register</button>
  </form>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
