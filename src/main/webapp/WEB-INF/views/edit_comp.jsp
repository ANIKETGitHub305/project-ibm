<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Compensation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e3f2fd, #f3e5f5);
            padding: 40px;
        }

        .container {
            background: white;
            max-width: 600px;
            margin: auto;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #0d47a1;
            font-size: 26px;
            margin-bottom: 30px;
        }

        h2 i {
            margin-right: 8px;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: 600;
            color: #333;
            font-size: 15px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px 14px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 16px;
        }

        button {
            margin-top: 30px;
            background: linear-gradient(to right, #42a5f5, #1e88e5);
            color: white;
            padding: 14px 25px;
            border: none;
            border-radius: 12px;
            font-weight: bold;
            font-size: 16px;
            width: 100%;
            cursor: pointer;
            box-shadow: 0 5px 12px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        button:hover {
            background: linear-gradient(to right, #1e88e5, #1565c0);
            transform: scale(1.02);
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            text-decoration: none;
            font-weight: bold;
            color: #8e24aa;
            font-size: 16px;
        }

        .back-link i {
            margin-right: 6px;
        }

        .error, .success {
            margin-top: 15px;
            padding: 12px;
            border-radius: 10px;
            font-weight: bold;
        }

        .error {
            background: #ffeaea;
            color: #d32f2f;
        }

        .success {
            background: #e8f5e9;
            color: #388e3c;
        }
    </style>
</head>
<body>
<div class="container">
    <h2><i class="fas fa-edit"></i> Edit Compensation</h2>

    <c:if test="${not empty message}">
        <div class="error">${message}</div>
    </c:if>

    <c:if test="${not empty msg}">
        <div class="success">${msg}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/compensation/update">
        <input type="hidden" name="id" value="${compensation.id}" />
        <input type="hidden" name="uid" value="${compensation.employee.uid}" />
        <input type="hidden" name="date" value="${compensation.date}" />
        <input type="hidden" name="type" value="${compensation.type}" />

        <!-- 🔒 These are for returning back -->
        <input type="hidden" name="yearMonth" value="${param.yearMonth}" />

        <label>Amount:</label>
        <input type="number" name="amount" value="${compensation.amount}" required />

        <label>Description:</label>
        <input type="text" name="description" value="${compensation.description}" required />

        <button type="submit"><i class="fas fa-save"></i> Update Compensation</button>
    </form>

    <!-- ✅ BACK BUTTON with uid and yearMonth -->
    <br/>
    <a href="javascript:history.go(-2) "class="back-link">← Back to Previous</a>
    <%-- <a class="back-link"
			href="${pageContext.request.contextPath}/compensation/breakdown">
			<i class="fas fa-arrow-left back-icon"></i>Back to Previous
		</a> --%>

</div>
</body>
</html>
