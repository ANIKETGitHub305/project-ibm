<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Compensation History</title>
</head>
<body>
<h2>Compensation History for UID: ${uid}</h2>
<p>Date Range: ${startDate} to ${endDate}</p>

<c:choose>
    <c:when test="${not empty compensations}">
        <table border="1" cellpadding="5">
            <tr>
                <th>Date</th>
                <th>Type</th>
                <th>Description</th>
                <th>Amount</th>
            </tr>
            <c:forEach var="comp" items="${compensations}">
                <tr>
                    <td>${comp.date}</td>
                    <td>${comp.type}</td>
                    <td>${comp.description}</td>
                    <td>${comp.amount}</td>
                </tr>
            </c:forEach>
        </table>
        <p><strong>Total Amount:</strong> ${totalAmount}</p>
    </c:when>
    <c:otherwise>
        <p>No compensation data found for selected range.</p>
    </c:otherwise>
</c:choose>

<br><a href="<c:url value='/employee/list'/>">Back to List</a>
</body>
</html>
