<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Moffat Bay Lodge</title>
  <link rel="stylesheet" href="<c:url value='/stylesheets/styles.css' />">
</head>
<body>
<header class="site-header">
  <div class="brand">Moffat Bay Lodge</div>
  <nav>
    <a href="<c:url value='/pages/index.jsp'/>">Home</a>
    <a href="<c:url value='/pages/about.jsp'/>">About</a>
    <a href="<c:url value='/pages/attractions.jsp'/>">Attractions</a>
    <c:choose>
      <c:when test="${not empty sessionScope.customerId}">
        <a href="<c:url value='/pages/reservation.jsp'/>">Make Reservation</a>
        <a href="<c:url value='/pages/lookup.jsp'/>">My Reservations</a>
        <a href="<c:url value='/logout'/>">Logout</a>
      </c:when>
      <c:otherwise>
        <a href="<c:url value='/pages/register.jsp'/>">Register</a>
        <a href="<c:url value='/pages/login.jsp'/>">Login</a>
        <a href="<c:url value='/pages/lookup.jsp'/>">Reservation Lookup</a>
      </c:otherwise>
    </c:choose>
  </nav>
</header>
<main class="page-content">