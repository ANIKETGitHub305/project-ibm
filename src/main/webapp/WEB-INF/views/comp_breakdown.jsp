<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Compensation Breakdown</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
	margin: 0;
	padding: 40px;
	font-family: 'Segoe UI', sans-serif;
	background: linear-gradient(to right, #e3f2fd, #f3e5f5);
}

.container {
	max-width: 900px;
	margin: auto;
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	animation: fadeIn 0.7s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(40px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
h2 {
	text-align: center;
	color: #5e35b1;
	margin-bottom: 30px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

th, td {
	padding: 14px;
	text-align: left;
	vertical-align: middle;
}

th {
	background-color: #7e57c2;
	color: white;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 14px;
}

tr:nth-child(even) {
	background-color: #f3e5f5;
}

tr:hover {
	background-color: #ede7f6;
	transition: 0.3s ease;
}

td {
	font-size: 15px;
	color: #333;
}

.bold {
	font-weight: bold;
	color: #4a148c;
}

.total-row {
	margin-top: 30px;
	text-align: right;
	font-size: 20px;
	font-weight: bold;
	color: #2e1662;
	background: #ede7f6;
	padding: 15px;
	border-radius: 12px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
}

.total-row i {
	margin-right: 8px;
	color: #7e57c2;
}

.back-link {
	display: inline-block;
	margin-top: 30px;
	font-size: 16px;
	font-weight: bold;
	color: #ffffff;
	background-color: #7e57c2;
	padding: 10px 18px;
	border-radius: 8px;
	text-decoration: none;
	transition: background 0.3s ease, transform 0.2s ease;
}

.back-link:hover {
	background-color: #5e35b1;
	transform: scale(1.05);
}

.back-icon {
	margin-right: 8px;
}

.edit-btn {
	background: linear-gradient(to right, #42a5f5, #1e88e5);
	color: white;
	padding: 8px 20px;
	border: none;
	font-size: 14px;
	font-weight: 600;
	border-radius: 25px;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
}

.edit-btn i {
	font-size: 13px;
}

.edit-btn:hover {
	background: linear-gradient(to right, #1e88e5, #1565c0);
	transform: scale(1.05);
}

.action-cell {
	text-align: center;
	vertical-align: middle;
}
</style>
</head>
<body>
	<div class="container">
		<h2>
			<i class="fas fa-chart-pie"></i> Compensation Breakdown for
			${yearMonth}
		</h2>

		<table>
			<tr>
				<th>Date</th>
				<th>Type</th>
				<th>Amount</th>
				<th>Description</th>
				<th>Action</th>
			</tr>
			<c:forEach var="comp" items="${compensations}">
				<tr>
					<td>${comp.date}</td>
					<td>${comp.type}</td>
					<td>₹${comp.amount}</td>
					<td><c:choose>
							<c:when test="${fn:length(comp.description) > 50}">
                            ${fn:substring(comp.description, 0, 50)}...
                        </c:when>
							<c:otherwise>
                            ${comp.description}
                        </c:otherwise>
						</c:choose></td>
					<td class="action-cell">
						<form method="get"
							action="${pageContext.request.contextPath}/compensation/edit">
							<input type="hidden" name="id" value="${comp.id}" /> <input
								type="hidden" name="uid" value="${uid}" /> <input type="hidden"
								name="yearMonth" value="${yearMonth}" />
							<button type="submit" class="edit-btn">
								<i class="fas fa-pen"></i> Edit
							</button>
						</form>


					</td>
				</tr>
			</c:forEach>
		</table>

		<div class="total-row">
			Total Compensation: <span class="bold">₹${total}</span>
		</div>
		<a href="javascript:history.back()" class="back-link">← Back to Previous</a>
	</div>
</body>
</html>
