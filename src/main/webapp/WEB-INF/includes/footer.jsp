
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
</main>
<footer class="site-footer">
   <link rel="stylesheet" href="<c:url value='/stylesheets/styles.css' />">
<script src="${pageContext.request.contextPath}/scripts/app.js"></script>
</body>
</html>
</main>
<footer class="site-footer">
  <section class="footer-grid">
    <div>
      <h4>Reservations Office</h4>
      <p>123 Marina Way, Joviedsa Island, WA</p>
      <p>(360) 555-0148</p>
      <p><a href="mailto:hello@moffatbay.com">hello@moffatbay.com</a></p>
    </div>
    <div>
      <h4>Office Hours</h4>
      <p>Mon–Fri 9:00–18:00 • Sat 9:00–12:00</p>
    </div>
        <div>
      <h4>Get Social</h4>
      <p><a href="#">Instagram</a> • <a href="#">Facebook</a></p>
    </div>
  </section>

  <div class="copyright">
    <p>© <%= java.time.Year.now() %> Moffat Bay Lodge</p>
  </div>

  </section>
</footer>
<script src="<c:url value='/scripts/app.js'/>"></script>
</body>
</html>
