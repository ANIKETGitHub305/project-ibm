<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f4f6f8;
            padding: 30px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #0d47a1;
            text-align: center;
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            background-color: #1976d2;
            color: white;
            padding: 12px 20px;
            margin-top: 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #0d47a1;
        }
        .msg {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
        .success {
            background-color: #c8e6c9;
            color: #256029;
        }
        .error {
            background-color: #ffcdd2;
            color: #c62828;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>✏️ Edit Employee</h2>

    <c:if test="${not empty errorMessage}">
        <div class="msg error">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="msg success">${successMessage}</div>
    </c:if>

    <form:form method="post" action="update" modelAttribute="employee">
        <form:hidden path="uid"/>

        <label>👤 First Name:</label>
        <form:input path="firstName"/>

        <label>🧑 Middle Name:</label>
        <form:input path="middleName"/>

        <label>👤 Last Name:</label>
        <form:input path="lastName"/>

        <label>🗓️ Birth Date:</label>
        <form:input path="birthDate" type="date"/>

        <label>🧑‍💼 Position:</label>
        <form:input path="position"/>

        <input type="submit" value="Update" class="btn"/>
    </form:form>

    <br><br>
    <a href="<c:url value='/employee/list'/>">⬅️ Back to List</a>
</div>

</body>
</html>
