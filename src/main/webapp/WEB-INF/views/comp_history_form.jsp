<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Compensation History Form</title>
</head>
<body>
<h2>Compensation History - Enter Date Range</h2>

<form method="post" action="compHistory">
    <input type="hidden" name="uid" value="${uid}"/>
    Start Date: <input type="date" name="startDate" required/><br><br>
    End Date: <input type="date" name="endDate" required/><br><br>
    <input type="submit" value="Get History"/>
</form>

<br><a href="<c:url value='/employee/list'/>">Back to List</a>
</body>
</html>
