<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Employees</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
            padding: 30px;
        }
        h2 {
            text-align: center;
            color: #1a237e;
            margin-bottom: 30px;
        }
        #filterBox {
            width: 100%;
            max-width: 400px;
            margin: 0 auto 20px auto;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            display: block;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            text-align: center;
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        th {
            background-color: #0d47a1;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            color: white;
            text-decoration: none;
            font-weight: bold;
            margin-right: 5px;
        }
        .edit-btn { background-color: #1e88e5; }
        .edit-btn:hover { background-color: #1565c0; }
        .delete-btn { background-color: #e53935; }
        .delete-btn:hover { background-color: #b71c1c; }
        .no-results {
            text-align: center;
            color: #e53935;
            font-style: italic;
            margin-top: 20px;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            font-weight: bold;
            color: #1565c0;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>👨‍💼 List of Employees</h2>

<input type="text" id="filterBox" placeholder="🔍 Filter by name or position..." onkeyup="filterTable()" />

<c:if test="${not empty employees}">
    <table id="employeeTable">
        <thead>
            <tr>
                <th>UID</th>
                <th>First Name</th>
                <th>Middle Name</th>
                <th>Last Name</th>
                <th>Birth Date</th>
                <th>Position</th>
                <th>Actions</th>
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
                    <td>
                        <a class="btn edit-btn" href="edit?uid=${emp.uid}">✏️ Edit</a>
                        <a class="btn delete-btn" href="delete?uid=${emp.uid}" onclick="return confirm('Are you sure you want to delete this employee?');">🗑️ Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

<c:if test="${empty employees}">
    <div class="no-results">😢 No employees found.</div>
</c:if>

<a href="<c:url value='/'/>" class="back-link">⬅ Back to Home</a>

<script type="text/javascript">
    function filterTable() {
        const input = document.getElementById("filterBox");
        const filter = input.value.toLowerCase();
        const table = document.getElementById("employeeTable");
        const rows = table.getElementsByTagName("tr");
        let visibleCount = 0;

        for (let i = 1; i < rows.length; i++) {
            const row = rows[i];
            const cells = row.getElementsByTagName("td");
            let match = false;

            for (let j = 1; j < cells.length - 1; j++) {
                if (cells[j].innerText.toLowerCase().includes(filter)) {
                    match = true;
                    break;
                }
            }

            row.style.display = match ? "" : "none";
            if (match) visibleCount++;
        }

        const noResultsMsg = document.querySelector(".no-results");
        if (noResultsMsg) {
            noResultsMsg.style.display = visibleCount === 0 ? "block" : "none";
        }
    }
</script>

</body>
</html>
