<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Employees</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 40px;
            background-color: #f4f6f8;
            color: #333;
        }

        h2 {
            color: #1a237e;
            font-size: 26px;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 600px;
        }

        label {
            font-weight: bold;
            display: inline-block;
            width: 120px;
            margin-bottom: 10px;
        }

        input[type="text"], input[type="submit"], input[type="reset"] {
            padding: 8px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
            width: 60%;
        }

        input[type="submit"], input[type="reset"] {
            width: auto;
            background-color: #1976d2;
            color: white;
            cursor: pointer;
            margin-right: 10px;
        }

        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #0d47a1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #1e88e5;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .no-result {
            font-style: italic;
            color: red;
            margin-top: 10px;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #1e88e5;
            font-weight: bold;
        }

        a:hover {
            color: #0d47a1;
        }
    </style>
</head>
<body>

<h2>🔍 Search Employees</h2>

<form action="search" method="get">
    <label>👨‍💼 First Name:</label>
    <input type="text" name="firstName" value="${firstName}" /><br>

    <label>👨 Last Name:</label>
    <input type="text" name="lastName" value="${lastName}" /><br>

    <label>🏢 Position:</label>
    <input type="text" name="position" value="${position}" /><br>

    <input type="submit" value="Search" />
    <input type="reset" value="Clear" />
</form>

<h3>📄 Search Results:</h3>

<c:choose>
    <c:when test="${not empty employees}">
        <table>
            <tr>
                <th>UID</th>
                <th>First Name</th>
                <th>Middle Name</th>
                <th>Last Name</th>
                <th>Birth Date</th>
                <th>Position</th>
            </tr>
            <c:forEach var="emp" items="${employees}">
                <tr>
                    <td>${emp.uid}</td>
                    <td>${emp.firstName}</td>
                    <td>${emp.middleName}</td>
                    <td>${emp.lastName}</td>
                    <td>${emp.birthDate}</td>
                    <td>${emp.position}</td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <p class="no-result">❗ 0 results found.</p>
    </c:otherwise>
</c:choose>

<a href="<c:url value='/'/>">⬅️ Back to Home</a>

</body>
</html>
