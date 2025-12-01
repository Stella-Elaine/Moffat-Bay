<%@ page contentType="text/html; charset=UTF-8" %>
</main>

<footer class="site-footer">
  <div class="footer-content">
    <p class="footer-contact">
      <a href="tel:+13605550148">+1 (360) 555-0148</a> • 
      <a href="mailto:hello@moffatbay.com">hello@moffatbay.com</a> • 
      <a href="<c:url value='/pages/about.jsp#contact' />">Full Contact Info</a>
    </p>
    <p class="footer-social">
      <a class="social-link" href="#" aria-label="Instagram">
        <img class="icon-sm" src="<c:url value='/photos/instagram-logo.png' />" alt="Instagram" />
      </a>
      <a class="social-link" href="#" aria-label="Facebook">
        <img class="icon-sm" src="<c:url value='/photos/facebook-logo.png' />" alt="Facebook" />
      </a>
    </p>
  </div>
  <div class="copyright">
    <p>© <%= java.time.Year.now() %> Moffat Bay Lodge</p>
  </div>
</footer>

<script src="<c:url value='/scripts/app.js'/>"></script>
</body>
</html>