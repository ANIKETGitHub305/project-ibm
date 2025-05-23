<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Compensation Breakdown Form</title></head>
<body>
    <h2>Compensation Breakdown</h2>
    <form action="compBreakdown" method="post">
        <input type="hidden" name="uid" value="${uid}" />
        Select Month (yyyy-MM): <input type="month" name="yearMonth" required />
        <input type="submit" value="View Breakdown" />
    </form>
</body>
</html>
