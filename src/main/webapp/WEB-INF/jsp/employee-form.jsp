<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Employee Form</title>
    <style>
        body{
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

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
        .h1-css {
            color: #1a73e8;
            text-align: center;
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

        .error {
            color: red;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1 class="h1-css">Register/Edit employee form</h1>
    <%--@elvariable id="employeeForm" type="org.jsp_demo.request.EmployeeForm"--%>
    <form:form action="employee-form" method="post" modelAttribute="employeeForm">
        <div class="form-group" id="form-group-employee-code">
            <form:label path="employeeCode">Employee Code</form:label>
            <form:input path="employeeCode" type="text"/>
            <form:errors path="employeeCode" cssClass="error" />
        </div>

        <div class="form-group">
            <form:label path="employeeName">Employee Name</form:label>
            <form:input path="employeeName" type="text"/>
            <form:errors path="employeeName" cssClass="error" />
        </div>

        <div class="form-group">
            <form:label path="birth">Birth Date</form:label>
            <form:input path="birth" type="date"/>
            <form:errors path="birth" cssClass="error" />
        </div>

        <div class="form-group">
            <form:label path="email">Email</form:label>
            <form:input path="email" type="email"/>
            <form:errors path="email" cssClass="error" />
        </div>

        <div class="form-group flex">
            <div class="flex-reverse">
                <form:label path="isManager">Manager</form:label>
                <form:checkbox path="isManager" value="1"/>
                <form:hidden path="isManager" value="0"/>
            </div>
            <div class="flex-reverse">
                    <%-- If value equal to the value -> checked --%>
                <form:label path="deleteFlag">Active</form:label>
                <form:checkbox path="deleteFlag" value="0"/>
                <form:hidden path="deleteFlag" value="1"/>
            </div>
        </div>

        <div class="form-group">
            <form:label path="managerCode">Manager Code</form:label>
            <form:select class="selection" path="managerCode">
                <option value=""></option>
                <jsp:useBean id="managerList" scope="request" type="java.util.List"/>
                <c:forEach items="${managerList}" var="emp">
                    <option value="${emp.employeeCode}"
                            <c:if test="${emp.selected == true}">selected</c:if>>${emp.employeeName}</option>
                </c:forEach>
            </form:select>
            <form:errors path="managerCode" cssClass="error" />
        </div>

        <div class="form-group">
            <form:label path="departmentCode"> Department</form:label>
            <form:select class="selection" path="departmentCode">
                <option value=""></option>
                <jsp:useBean id="departmentList" scope="request" type="java.util.List"/>
                <c:forEach items="${departmentList}" var="dept">
                    <option value="${dept.departmentCode}"
                            <c:if test="${dept.selected == true}">selected</c:if>>${dept.departmentName}</option>
                </c:forEach>
            </form:select>
            <form:errors path="departmentCode" cssClass="error" />

        </div>

        <div class="form-group">
            <button class="btn-submit">Save/Edit</button>
        </div>


    </form:form>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.getElementById('employeeForm').addEventListener('submit', function (event) {
        const currentParams = new URLSearchParams(window.location.search);
        if (currentParams.toString()) {
            let action = this.action;
            action = action + `?` + currentParams;
            this.action = action;
        }
    });

    $(document).ready(function () {
        const currentParams = new URLSearchParams(window.location.search);
        if (currentParams.toString()) {
            let employeeCode = $("#employeeCode");
            if (employeeCode) {
                employeeCode.prop('readonly', true)
            }
        } else {
            let employeeCode = $("#form-group-employee-code");
            employeeCode.css('display', 'none');
        }

    });
</script>
</html>
