<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <title>Employee Form</title>
    <style>

        .form-container {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin-top: 50px;
        }

        .form-container h2 {
            text-align: center;
            color: #1a73e8;
        }

        .form-container .form-group {
            margin-bottom: 15px;
        }

        .form-container label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .form-container input[type="text"],
        input[type="email"],
        input[type="date"],
        select,
        input[type="checkbox"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-container input[type="checkbox"] {
            width: auto;
            margin-right: 10px;
        }

        .btn-submit {
            background-color: #1a73e8;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .btn-submit:hover {
            background-color: #155f9f;
        }

        .flex {
            display: flex;
            justify-content: space-between;
        }

        .flex-reverse {
            align-items: center;
            display: flex;
            flex-flow: column;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Employee Form</h2>
    <div id="form-employee">
        <div class="form-group">
            <label for="form-employee-employeeCode">Employee Code</label>
            <input type="text" id="form-employee-employeeCode" name="employeeCode" disabled>
        </div>

        <div class="form-group">
            <label for="form-employee-employeeName">Employee Name</label>
            <input type="text" id="form-employee-employeeName" name="employeeName" required>
        </div>

        <div class="form-group">
            <label for="form-employee-birth">Birth Date</label>
            <input type="date" id="form-employee-birth" name="birth" required>
        </div>

        <div class="form-group">
            <label for="form-employee-email">Email</label>
            <input type="email" id="form-employee-email" name="email" required>
        </div>

        <div class="form-group flex">
            <div class="flex-reverse">
                <label for="form-employee-isManager">Manager</label>
                <input type="checkbox" id="form-employee-isManager" name="isManager">
            </div>
            <div class="flex-reverse">
                <label for="form-employee-isActive">Active</label>
                <input type="checkbox" id="form-employee-isActive" name="deleteFlag">
            </div>
        </div>

        <div class="form-group">
            <label for="form-employee-managerSelect">Manager Code</label>
            <select id="form-employee-managerSelect" class="selection" name="managerCode">
                <option value=""></option>
                <c:forEach items="${managerList}" var="emp">
                    <option value="${emp.employeeCode}"
                            <c:if test="${emp.selected == true}">selected</c:if>>${emp.employeeName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="form-employee-departmentSelect">Department</label>
            <select id="form-employee-departmentSelect" class="selection" name="departmentCode">
                <option value=""></option>
                <c:forEach items="${departmentList}" var="dept">
                    <option value="${dept.departmentCode}"
                            <c:if test="${dept.selected == true}">selected</c:if>>${dept.departmentName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <button class="btn-submit" onclick="btnSaveEditClick()">Save/Edit</button>
        </div>
    </div>
</div><%--@elvariable id="employeeForm" type="org.jsp_demo.request.EmployeeFormTest"--%>
<form:form action="submitEmployeeForm" method="post" modelAttribute="employeeForm">
    <div>
        <form:label path="employeeCode">Employee Code:</form:label>
        <form:input path="employeeCode" />
        <form:errors path="employeeCode" cssClass="error" />
    </div>
    <div>
        <form:label path="employeeName">Employee Name:</form:label>
        <form:input path="employeeName" />
        <form:errors path="employeeName" cssClass="error" />
    </div>
    <!-- Add other form fields here -->
    <div>
        <input type="submit" value="Submit" />
    </div>
</form:form>

<c:if test="${not empty successMessage}">
    <p style="color: green;">${successMessage}</p>
</c:if>
</body>
</html>
