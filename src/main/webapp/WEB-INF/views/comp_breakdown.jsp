<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Compensation Breakdown</title></head>
<body>
    <h2>Breakdown for ${yearMonth}</h2>
    <table border="1" cellpadding="5">
        <tr><th>Type</th><th>Amount</th></tr>
        <tr><td>Salary</td><td>${salary}</td></tr>
        <tr><td>Bonus</td><td>${bonus}</td></tr>
        <tr><td>Other</td><td>${other}</td></tr>
    </table>
    <br><a href="list">Back to List</a>
</body>
</html>
