<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>IBM Employee Management System</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --bg-light: #f5f9ff;
      --bg-dark: #121212;
      --text-light: #111;
      --text-dark: #f1f1f1;
      --header-light: #1a237e;
      --header-dark: #0d0d2b;
      --btn-light: #1e88e5;
      --btn-dark: #90caf9;
      --btn-hover-light: #1565c0;
      --btn-hover-dark: #64b5f6;
      --card-light: #ffffff;
      --card-dark: #1f1f1f;
      --tab-light: #c5cae9;
      --tab-dark: #2c2c2c;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      width: 100%;
      height: 100%;
      font-family: 'Inter', sans-serif;
    }

    body.light {
      background: var(--bg-light);
      color: var(--text-light);
    }

    body.dark {
      background: var(--bg-dark);
      color: var(--text-dark);
    }

    body {
      display: flex;
      flex-direction: column;
      transition: background 0.3s ease, color 0.3s ease;
      overflow-x: hidden;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: var(--header-light);
      padding: 16px 32px;
      color: white;
      transition: background 0.3s ease;
    }

    body.dark header {
      background-color: var(--header-dark);
      color: var(--text-dark);
    }

    header .logo-title {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      text-align: center;
      position: relative;
    }

    header img {
      height: 48px;
      position: absolute;
      left: 0;
      top: 50%;
      transform: translateY(-50%);
      filter: brightness(0) invert(1);
    }

    .dark header img {
      filter: brightness(1.2) invert(0.9);
    }

    header h1 {
      font-size: 24px;
      font-weight: 700;
      margin: 0 auto;
    }

    .toggle-wrapper {
      position: absolute;
      right: 32px;
    }

    .dark-toggle {
      cursor: pointer;
      padding: 8px 16px;
      border: none;
      border-radius: 20px;
      background-color: #ffffff33;
      color: white;
      font-weight: bold;
    }

    nav {
  background: var(--tab-light);
  display: flex;
  justify-content: center;
  gap: 40px;
  padding: 12px 0;
  transition: background 0.3s ease;
  margin-bottom: 32px; /* 👈 Neat visual spacing */
}

    .dark nav {
      background: var(--tab-dark);
    }

    .tab-button {
      padding: 12px 24px;
      border: none;
      border-radius: 10px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      background-color: transparent;
    }

    .dark .tab-button {
      background-color: transparent;
      color: var(--text-dark);
    }

    .tab-button.active {
      background-color: #ffffff;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .dark .tab-button.active {
      background-color: #333;
    }

    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 40px;
      position: relative;
    }

    .card {
      background-color: var(--card-light);
      padding: 40px;
      width: 100%;
      max-width: 960px;
      border-radius: 20px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
      position: absolute;
      top: 0;
      transition: transform 0.5s ease, opacity 0.5s ease, background-color 0.3s ease;
    }

    .dark .card {
      background-color: var(--card-dark);
      box-shadow: 0 6px 20px rgba(255,255,255,0.05);
    }

    .section-title {
      font-size: 28px;
      margin-bottom: 30px;
    }

    .btn {
      display: inline-block;
      padding: 15px 30px;
      margin: 10px;
      font-size: 16px;
      background-color: var(--btn-light);
      color: white;
      text-decoration: none;
      border-radius: 10px;
      transition: all 0.3s ease;
      font-weight: 600;
    }

    .btn:hover {
      background-color: var(--btn-hover-light);
      transform: scale(1.05);
    }

    .dark .btn {
      background-color: var(--btn-dark);
      color: #000;
    }

    .dark .btn:hover {
      background-color: var(--btn-hover-dark);
    }

    footer {
      text-align: center;
      padding: 12px;
      font-size: 14px;
      color: #666;
      background: #f0f0f0;
      transition: background 0.3s ease, color 0.3s ease;
    }

    .dark footer {
      background: #1a1a1a;
      color: #999;
    }

    #loader {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: white;
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 9999;
    }

    .dark #loader {
      background: #121212;
    }

    .spinner {
      border: 6px solid #eee;
      border-top: 6px solid #1e88e5;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      to {
        transform: rotate(360deg);
      }
    }

    .tab-content {
      opacity: 0;
      transform: translateX(100%);
      pointer-events: none;
    }

    .tab-content.active {
      opacity: 1;
      transform: translateX(0);
      pointer-events: all;
    }
  </style>
</head>
<body class="light">
  <div id="loader"><div class="spinner"></div></div>

  <header>
    <div class="logo-title">
      <img src="/resources/images/IBM-Logo.jpg" alt="IBM Logo"
           onerror="this.onerror=null; this.src='https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg'">
      <h1>IBM Employee Management System</h1>
    </div>
    <div class="toggle-wrapper">
      <button class="dark-toggle" onclick="toggleDarkMode()">🌓 Mode</button>
    </div>
  </header>

  <nav>
    <button class="tab-button active" onclick="switchTab('employeeSection')">👤 Employees</button>
    <button class="tab-button" onclick="switchTab('compensationSection')">💰 Compensation</button>
  </nav>

  <main>
    <div class="card tab-content active" id="employeeSection">
      <div class="section-title">👤 Employee Management</div>
      <a href="employee/add" class="btn">➕ Add Employee</a>
      <a href="employee/search" class="btn">🔍 Search Employee</a>
      <a href="employee/list" class="btn">✏️ View/Edit Employee</a>
    </div>

    <div class="card tab-content" id="compensationSection">
      <div class="section-title">💰 Compensation Management</div>
      <a href="compensation/add" class="btn">➕ Add Compensation</a>
      <a href="compensation/history" class="btn">📆 View History</a>
      <a href="compensation/monthly-entry" class="btn">📊 Monthly Breakdown</a>
      <a href="compensation/edit" class="btn">✏️ Edit Compensation</a>
    </div>
  </main>

  <footer>© 2025 IBM Corp. All rights reserved.</footer>

  <script>
    function toggleDarkMode() {
      document.body.classList.toggle('dark');
      document.body.classList.toggle('light');
    }

    function switchTab(tabId) {
      document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.remove('active');
      });
      document.getElementById(tabId).classList.add('active');

      const buttons = document.querySelectorAll('.tab-button');
      buttons.forEach(btn => btn.classList.remove('active'));
      if (tabId === 'employeeSection') buttons[0].classList.add('active');
      else buttons[1].classList.add('active');
    }

    window.onload = () => {
      setTimeout(() => {
        document.getElementById('loader').style.display = 'none';
      }, 500);
    };
  </script>
</body>
</html>
