<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Compensation Breakdown Entry</title>

    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e3f2fd, #ede7f6);
            margin: 0;
            padding: 50px 15px;
        }

        .container {
            background: #fff;
            border-radius: 18px;
            padding: 40px 35px;
            max-width: 680px;
            margin: auto;
            box-shadow: 0 14px 30px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @keyframes slideFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeOut {
            from { opacity: 1; transform: translateY(0); }
            to { opacity: 0; transform: translateY(-20px); }
        }

        h2 {
            text-align: center;
            font-size: 28px;
            color: #4527a0;
            margin-bottom: 35px;
        }

        label {
            font-weight: bold;
            margin: 20px 0 10px;
            display: block;
            font-size: 16px;
        }

        select,
        input[type="month"],
        .select2-container--default .select2-selection--single {
            width: 100%;
            padding: 12px 14px;
            font-size: 15px;
            border-radius: 12px;
            border: 1px solid #ccc;
            transition: 0.3s ease;
            height: 46px;
            box-sizing: border-box;
        }

        select:focus,
        input[type="month"]:focus,
        .select2-container--default .select2-selection--single:focus {
            outline: none;
            border-color: #5e35b1;
            box-shadow: 0 0 0 4px rgba(94, 53, 177, 0.2);
        }

        button {
            margin-top: 35px;
            padding: 15px;
            width: 100%;
            font-size: 17px;
            font-weight: bold;
            color: white;
            background: linear-gradient(to right, #5c6bc0, #8e24aa);
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: linear-gradient(to right, #3f51b5, #6a1b9a);
        }

        .back-link {
            display: block;
            margin-top: 30px;
            text-align: center;
            color: #6a1b9a;
            text-decoration: none;
            font-weight: 600;
        }

        .back-link:hover {
            color: #4a148c;
        }

        /* SELECT2 Fixes */
        .select2-container {
            width: 100% !important;
        }

        .select2-selection--single {
            height: 46px !important;
            padding: 8px 14px;
            font-size: 16px;
            display: flex !important;
            align-items: center;
            border-radius: 12px;
            border: 1px solid #ccc;
        }

        .select2-selection__rendered {
            color: #333 !important;
            font-size: 15px;
            line-height: normal !important;
        }

        .select2-selection__arrow {
            height: 100% !important;
        }

        .select2-selection__clear {
            display: none !important;
        }

        .error-message {
            background-color: #ffebee;
            color: #b71c1c;
            padding: 14px 20px;
            border-left: 6px solid #b71c1c;
            border-radius: 8px;
            font-weight: bold;
            margin-bottom: 20px;
            animation: slideFadeIn 0.6s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <h2><i class="fas fa-chart-pie"></i> Compensation Breakdown Entry</h2>

    <c:if test="${not empty error}">
        <div id="errorBox" class="error-message">
            <i class="fas fa-exclamation-triangle"></i>
            ${error}
        </div>
    </c:if>

    <form action="breakdown" method="post" onsubmit="return fillHiddenUid();">

        <label for="employeeSelect"><i class="fas fa-user-tag"></i> Select Employee:</label>
        <select id="employeeSelect" name="uid" class="select2" required>
            <option value="">-- Select Employee --</option>
            <c:forEach var="emp" items="${employees}">
                <option value="${emp.uid}">${emp.uid} - ${emp.firstName} ${emp.lastName}</option>
            </c:forEach>
        </select>

        <label for="yearMonth"><i class="fas fa-calendar-alt"></i> Select Year & Month</label>
        <input type="month" name="yearMonth" required/>

        <input type="hidden" name="uid" id="finalUid"/>

        <button type="submit"><i class="fas fa-eye"></i> View Breakdown</button>
    </form>

    <a class="back-link" href="<c:url value='/'/>"><i class="fas fa-arrow-left"></i> Back to Home</a>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    $(document).ready(function () {
        $('#employeeSelect').select2({
            placeholder: "Search by name or ID",
            allowClear: false,
            width: 'resolve'
        });

        // Auto-hide error box after 5s
        const errorBox = document.getElementById('errorBox');
        if (errorBox) {
            setTimeout(() => {
                errorBox.style.animation = 'fadeOut 0.6s ease-out forwards';
                setTimeout(() => errorBox.remove(), 700);
            }, 5000);
        }
    });

    function fillHiddenUid() {
        const selectedUid = $('#employeeSelect').val();
        if (selectedUid) {
            $('#finalUid').val(selectedUid);
            return true;
        } else {
            alert("Please select an employee.");
            return false;
        }
    }
</script>
</body>
</html>
