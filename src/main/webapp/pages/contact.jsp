<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

 <jsp:include page="/WEB-INF/includes/header.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/styles.css">
<section class="hero">
  <div class="inner">
    <h1>Contact Us</h1>
    <p>Questions about rooms, dates, or travel to the island? Send a note—our desk team is quick to reply.</p>
  </div>
</section>

<section class="container mt-3">
  <div class="grid grid-2">
    <form class="card" action="#" method="post" onsubmit="return false;">
      <div class="grid grid-2">
        <div>
          <label for="name">Full Name</label>
          <input id="name" type="text" placeholder="First and Last" required />
        </div>
        <div>
          <label for="email">Email</label>
          <input id="email" type="email" placeholder="you@example.com" required />
        </div>
      </div>

      <label for="msg" class="mt-2">Message</label>
      <textarea id="msg" placeholder="How can we help?"></textarea>

      <button class="btn mt-2" type="submit">Send Message</button>
    </form>

    <aside class="card">
      <h3>Reservations Office</h3>
      <p>123 Marina Way, Joviedsa Island WA<br>+1 (360) 555-0148<br>hello@moffatbay.com</p>
      <h3>Office Hours</h3>
      <p>Mon–Fri 9:00–18:00 • Sat 9:00–12:00</p>
      <h3>Social</h3>
      <p><a href="#">Instagram</a> • <a href="#">Facebook</a></p>
    </aside>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
