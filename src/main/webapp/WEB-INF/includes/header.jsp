
<!-- this will be imported into the pages as a header so the functionality and DB work together. -->
  <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Moffat Bay Lodge</title>

  <!-- Global CSS for all pages do not remove this link! -->
   <link rel="stylesheet" href="<c:url value='/stylesheets/styles.css' />">

</head>
<body>
<header>
  <nav class="navbar">
    <div class="nav-left">
      <a href="${pageContext.request.contextPath}/pages/index.jsp" class="brand">
        <strong>Moffat Bay Lodge</strong>
      </a>
      <span class="tagline">Joviedsa Island • San Juan Islands, Washington</span>
    </div>
    <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/pages/about.jsp">About</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/attractions.jsp">Attractions</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/register.jsp">Register</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/login.jsp">Login</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/lookup.jsp">Reservation Lookup</a></li>
    </ul>
  </nav>
</header>
<main class="page-content">
