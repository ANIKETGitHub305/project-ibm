<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Employees</title>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 40px;
            background: linear-gradient(to right, #e3f2fd, #ffffff);
            color: #333;
        }

        h2 {
            color: #0d47a1;
            font-size: 30px;
            margin-bottom: 25px;
            border-bottom: 2px solid #1976d2;
            padding-bottom: 10px;
            display: inline-block;
        }

        form {
            margin-bottom: 40px;
            padding: 25px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 700px;
        }

        label {
            font-weight: bold;
            display: inline-block;
            width: 140px;
            margin-bottom: 15px;
        }

        input[type="text"] {
            padding: 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 60%;
            margin-bottom: 15px;
        }

        .form-buttons {
            margin-top: 10px;
        }

        input[type="submit"], button {
            padding: 10px 20px;
            font-size: 15px;
            border: none;
            border-radius: 6px;
            background-color: #1976d2;
            color: white;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #0d47a1;
        }

        /* Scrollable container for table */
        .scrollable-table {
            max-height: 420px;
            overflow-y: auto;
            border-radius: 12px;
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e3f2fd;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #1e88e5;
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .no-result {
            font-style: italic;
            color: red;
            margin-top: 20px;
            font-weight: bold;
        }

        a {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            color: #1976d2;
            font-weight: bold;
        }

        a:hover {
            color: #0d47a1;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-thumb {
            background-color: #90caf9;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-track {
            background-color: #e3f2fd;
            border-radius: 10px;
        }
    </style>

    <script>
        function clearSearchForm() {
            document.querySelector('form').reset();
            window.location.href = '<c:url value="/employee/search"/>';
        }
    </script>
</head>
<body>

<h2>🔍 Search Employees</h2>

<form action="search" method="get">
    <label>👨‍💼 First Name:</label>
    <input type="text" name="firstName" value="${param.firstName}" /><br>

    <label>👨 Last Name:</label>
    <input type="text" name="lastName" value="${param.lastName}" /><br>

    <label>🏢 Position:</label>
    <input type="text" name="position" value="${param.position}" /><br>

    <div class="form-buttons">
        <input type="submit" value="🔍 Search" />
        <button type="button" onclick="clearSearchForm()">🧹 Clear</button>
    </div>
</form>

<c:if test="${not empty employees}">
    <h3 style="color: #1565c0; margin-top: 40px;">📄 Search Results:</h3>
    
    <div class="scrollable-table">
        <table>
            <thead>
                <tr>
                    <th>UID</th>
                    <th>First Name</th>
                    <th>Middle Name</th>
                    <th>Last Name</th>
                    <th>Birth Date</th>
                    <th>Position</th>
                </tr>
            </thead>
            <tbody>
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
            </tbody>
        </table>
    </div>
</c:if>

<c:if test="${empty employees and (param.firstName != null or param.lastName != null or param.position != null)}">
    <p class="no-result">❗ No results found for your search.</p>
</c:if>

<a href="<c:url value='/'/>">⬅️ Back to Home</a>

</body>
</html>
