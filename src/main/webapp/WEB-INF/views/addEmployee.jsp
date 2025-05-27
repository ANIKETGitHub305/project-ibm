<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e3f2fd, #fce4ec);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 60px auto;
            padding: 35px 40px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        h2 {
            text-align: center;
            color: #1a237e;
            font-size: 28px;
            margin-bottom: 20px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 20px;
            color: #2c3e50;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 12px 15px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
        }

        input:focus {
            outline: none;
            border-color: #1a237e;
            box-shadow: 0 0 5px rgba(26, 35, 126, 0.3);
        }

        .btn {
            margin-top: 30px;
            width: 100%;
            padding: 14px;
            background: linear-gradient(to right, #1a237e, #3949ab);
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .btn:hover {
            background: linear-gradient(to right, #0d1759, #303f9f);
        }

        .error {
            color: #e53935;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            font-weight: bold;
            color: #1a237e;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .toast {
            visibility: hidden;
            min-width: 260px;
            background-color: #43a047;
            color: white;
            text-align: center;
            border-radius: 6px;
            padding: 14px;
            position: fixed;
            z-index: 1000;
            left: 50%;
            top: 20px;
            transform: translateX(-50%);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
            font-size: 16px;
        }

        .toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 3s;
        }

        @keyframes fadein {
            from { top: 0; opacity: 0; }
            to { top: 20px; opacity: 1; }
        }

        @keyframes fadeout {
            from { top: 20px; opacity: 1; }
            to { top: 0; opacity: 0; }
        }
    </style>
</head>
<body>
<div class="toast" id="toast"></div>

<div class="container">
    <h2>➕ Add Employee</h2>

    <form:form method="post" action="add" modelAttribute="employee">
        <form:errors path="*" cssClass="error"/>

        <label>👨‍💼 First Name:</label>
        <form:input path="firstName" required="true" />
        <form:errors path="firstName" cssClass="error" />

        <label>👤 Middle Name:</label>
        <form:input path="middleName" />
        <form:errors path="middleName" cssClass="error" />

        <label>👨‍💼 Last Name:</label>
        <form:input path="lastName" required="true" />
        <form:errors path="lastName" cssClass="error" />

        <label>🗓️ Birth Date:</label>
        <form:input path="birthDate" type="date" required="true" />
        <form:errors path="birthDate" cssClass="error" />

        <label>🏢 Position:</label>
        <form:input path="position" required="true" />
        <form:errors path="position" cssClass="error" />

        <button type="submit" class="btn">✅ Add Employee</button>
    </form:form>

    <a class="back-link" href="<c:url value='/'/>">⬅️ Back to Home</a>
</div>

<script type="module">
    const toast = document.getElementById("toast");

    const showToast = (message, color = '#43a047') => {
        toast.textContent = message;
        toast.style.backgroundColor = color;
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 4000);
    };

    <c:if test="${not empty msg}">
        showToast('${msg}');
    </c:if>
    <c:if test="${not empty error}">
        showToast('${error}', '#e53935');
    </c:if>
</script>
</body>
</html>
