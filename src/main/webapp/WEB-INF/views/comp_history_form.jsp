<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Compensation History Form</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
            padding: 40px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 35px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            display: block;
            margin: 15px 0 5px;
            color: #1a237e;
        }

        select, input[type="date"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        .btn {
            width: 100%;
            padding: 14px;
            margin-top: 20px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background: #1976d2;
            color: white;
        }

        .btn-primary:hover {
            background: #0d47a1;
        }

        .btn-secondary {
            background: #9e9e9e;
            color: white;
        }

        .btn-secondary:hover {
            background: #616161;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            text-decoration: none;
            color: #6a1b9a;
            font-weight: 600;
        }

        .back-link i {
            margin-right: 5px;
        }

        .back-link:hover {
            color: #4a148c;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📊 Compensation History - Enter Employee & Date Range</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form id="historyForm" method="post" action="history">
        <label><i class="fas fa-user"></i> Select Employee:</label>
        <select id="employeeSelect" name="uid" required>
            <option value="">-- Select Employee --</option>
            <c:forEach var="emp" items="${employees}">
                <option value="${emp.uid}">${emp.uid} - ${emp.firstName} ${emp.lastName}</option>
            </c:forEach>
        </select>

        <label><i class="fas fa-calendar-alt"></i> Start Date:</label>
        <input type="date" name="startDate" id="startDate" required />

        <label><i class="fas fa-calendar-alt"></i> End Date:</label>
        <input type="date" name="endDate" id="endDate" required />

        <div class="action-buttons">
            <button class="btn btn-primary" type="submit"><i class="fas fa-database"></i> Get History</button>
            <button class="btn btn-secondary" type="button" onclick="clearForm()"><i class="fas fa-broom"></i> Clear</button>
        </div>
    </form>

    <!-- 🔁 Back to Home link -->
    <a class="back-link" href="<c:url value='/'/>"><i class="fas fa-arrow-left"></i> Back to Home</a>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    function clearForm() {
        document.getElementById("historyForm").reset();
        $('#employeeSelect').val('').trigger('change');
    }

    $(document).ready(function () {
        $('#employeeSelect').select2({
            placeholder: "-- Select Employee --",
            allowClear: true,
            width: '100%'
        });
    });
</script>
</body>
</html>
