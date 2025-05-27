<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Compensation History</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #eef3f9;
            margin: 0;
            padding: 40px;
            display: flex;
            justify-content: center;
        }

        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
            width: 100%;
            max-width: 850px;
            animation: fadeIn 0.8s ease-in-out;
        }

        .header-block {
            background: linear-gradient(to right, #003973, #e5e5be);
            color: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
        }

        .header-block h2 {
            margin: 0 0 10px;
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .header-block p {
            margin: 0;
            font-size: 16px;
            font-weight: 500;
        }

        .error {
            background-color: #ffeded;
            color: #d00000;
            padding: 10px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            border-left: 4px solid #d00000;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #1e2a44;
            color: white;
            font-size: 16px;
        }

        tr:nth-child(even) {
            background-color: #f8fafd;
        }

        tr:hover {
            background-color: #edf2fa;
        }

        .breakdown-btn {
            background-color: #1e88e5;
            color: white;
            padding: 8px 14px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .breakdown-btn:hover {
            background-color: #1565c0;
        }

        .back-button {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 18px;
            font-weight: 600;
            color: #003973;
            background-color: #f0f4fc;
            border: 2px solid #003973;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            background-color: #003973;
            color: white;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Error Display -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <!-- Stylish Header Block -->
    <div class="header-block">
        <h2>📊 Monthly Compensation History for UID: ${uid}</h2>
        <p>🗓️ Date Range: <strong>${startDate}</strong> to <strong>${endDate}</strong></p>
    </div>

    <!-- Compensation Table -->
    <c:if test="${not empty monthlyTotals}">
        <table id="compensationTable">
            <tr>
                <th>Month</th>
                <th>Total Compensation</th>
                <th>Breakdown</th>
            </tr>
            <c:forEach var="entry" items="${monthlyTotals}">
                <tr>
                    <td>${entry.key}</td>
                    <td>${entry.value}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/compensation/breakdown" method="post">
                            <input type="hidden" name="uid" value="${uid}"/>
                            <input type="hidden" name="yearMonth" value="${entry.key}"/>
                            <button type="submit" class="breakdown-btn">Monthly Breakdown</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <!-- No Data Message -->
    <c:if test="${empty monthlyTotals}">
        <p>No compensation data found for selected range.</p>
    </c:if>

    <!-- Back Button -->
    <a href="javascript:history.back()" class="back-button">← Back to Previous</a>
</div>

<!-- TypeScript Animation -->
<script type="module">
    window.addEventListener('DOMContentLoaded', () => {
        const rows = document.querySelectorAll<HTMLTableRowElement>('#compensationTable tr');
        rows.forEach((row, index) => {
            row.style.opacity = '0';
            setTimeout(() => {
                row.style.transition = 'opacity 0.6s ease-out';
                row.style.opacity = '1';
            }, index * 100);
        });
    });
</script>
</body>
</html>
