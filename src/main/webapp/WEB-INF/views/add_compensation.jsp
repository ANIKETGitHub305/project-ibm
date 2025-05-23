<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Add Compensation</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            padding: 40px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            position: relative;
        }

        h2 {
            text-align: center;
            color: #1a237e;
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
            margin-top: 15px;
            display: block;
        }

        select, input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .btn {
            background-color: #1976d2;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0d47a1;
        }

        .flash-message {
            padding: 12px;
            color: #fff;
            font-weight: bold;
            text-align: center;
            border-radius: 5px;
            position: absolute;
            top: -50px;
            left: 0;
            width: 100%;
            opacity: 0;
            animation: fadeInOut 5s ease-in-out;
        }

        .flash-success { background-color: #4caf50; }
        .flash-error { background-color: #f44336; }

        @keyframes fadeInOut {
            0% { opacity: 0; top: -50px; }
            10% { opacity: 1; top: 0; }
            90% { opacity: 1; top: 0; }
            100% { opacity: 0; top: -50px; }
        }

        .refresh-btn {
            margin-top: 20px;
            text-align: center;
        }

        .refresh-btn button {
            padding: 10px 20px;
            font-size: 14px;
            background-color: #e0e0e0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .refresh-btn button:hover {
            background-color: #bdbdbd;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>➕ Add Compensation</h2>

    <!-- ✅ Flash message -->
    <c:if test="${not empty message}">
    <div class="flash-message flash-error">${message}</div>
</c:if>
<c:if test="${not empty msg}">
    <div class="flash-message flash-success">${msg}</div>
    <script>
        setTimeout(() => {
            window.location.href = "/employmentsystem/compensation/add";
        }, 2500);
    </script>
</c:if>


    <form:form method="post" action="/employmentsystem/compensation/save" modelAttribute="compensation">
        
        <!-- 🔍 Searchable Employee Dropdown -->
        <label>👤 Select Employee:</label>
        <select id="employeeSelect" name="employee.uid">
            <option value="">-- Select Employee --</option>
            <c:forEach var="emp" items="${employees}">
                <option value="${emp.uid}">${emp.uid} - ${emp.firstName} ${emp.lastName}</option>
            </c:forEach>
        </select>

        <label>💼 Compensation Type:</label>
        <form:select path="type">
            <form:option value="SALARY" label="SALARY"/>
            <form:option value="BONUS" label="BONUS"/>
            <form:option value="COMMISSION" label="COMMISSION"/>
            <form:option value="ALLOWANCE" label="ALLOWANCE"/>
            <form:option value="ADJUSTMENT" label="ADJUSTMENT"/>
        </form:select>

        <label>💰 Amount:</label>
        <form:input path="amount"/>

        <label>📝 Description:</label>
        <form:input path="description"/>

        <label>📅 Date:</label>
        <form:input path="date" type="date"/>

        <button type="submit" class="btn">✅ Add Compensation</button>
    </form:form>

    <!-- 🔄 Manual Refresh Button -->
   <div class="refresh-btn">
    <button onclick="window.location.href='/employmentsystem/compensation/add'">🔄 Refresh Page</button>
</div>

<!-- ✅ Include Select2 and jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function() {
        $('#employeeSelect').select2({
            placeholder: "-- Select Employee --",
            allowClear: true,
            width: '100%'
        });
    });
</script>
</body>
</html>
