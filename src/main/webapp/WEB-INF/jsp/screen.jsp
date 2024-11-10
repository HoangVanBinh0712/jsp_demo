<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage</title>
    <style>
        body {
            font-size: 20px;
        }
        table {
            border-collapse: collapse;
            font-family: Arial, sans-serif;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        thead {
            background-color: #1a73e8;
        }
        thead tr {
            width: 100%;
            border: 1px solid #1a73e8;
            background: transparent;
        }
        thead th {
            color: white;
            text-align: left;
            padding: 5px;
        }
        tbody th, td {
            border: 1px solid #1a73e8;
            text-align: left;
            padding: 5px;
        }

        tbody th {
            background-color: #e8f0fe;
            color: #1a73e8;
            font-weight: bold;
        }

        tbody .input-text, .selection {
            width: 100%;
            box-sizing: border-box;
            border: 1px solid #1a73e8;
            border-radius: 2px;
            outline: none;
            transition: border-color 0.3s;
            padding: 7px;
        }

        tbody tr button {
            text-align: center;
            padding: 7px;
            border: 1px solid #1a73e8;
            width: 100%;
            cursor: pointer
        }
        tbody tr button:hover {
            background: #1a73e8;
            color: white;
        }
        .input-text:focus, .selection:focus {
            border-color: #0b57d0;
        }

        .td-checkbox {
            text-align: center;
        }

        .border-none {
            border: none;
        }
    </style>
</head>
<body>
<table class="table-search">
    <thead>
    <tr>
      <th colspan="10">Search options</th>
    </tr>
    </thead>
    <tbody>
    <form id="form-search" onsubmit="employee" method="get">
        <tr>
            <th>Name <input type="hidden" value="1" name="search"></th>
            <td colspan="3"><input type="text" class="input-text" name="empName" value="${searchName}"></td>
        </tr>
        <tr>
            <th>Department</th>
            <td><select class="selection" name="department">
                <option value=""></option>
                <c:forEach items="${departmentList}" var="dept">
                <option value="${dept.departmentCode}" <c:if test="${dept.selected == true}">selected</c:if>>${dept.departmentName}</option>
                </c:forEach>
            </select></td>
            <th>Manager</th>
            <td><select class="selection" name="manager">
                <option value=""></option>
                <c:forEach items="${managerList}" var="emp">
                    <option value="${emp.employeeCode}" <c:if test="${emp.selected == true}">selected</c:if>>${emp.employeeName}</option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td class="border-none"></td>
            <td class="border-none"></td>
            <td class="border-none"></td>
            <td class="border-none"><button id="btn-submit" type="submit" >Search</button></td>
        </tr>
    </form>

    </tbody>
</table>
<br>
<table class="table-data">
    <thead>
    <tr>
        <th colspan="10">Search data</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>Selected</th>
        <th>Employee code</th>
        <th>Employee name</th>
        <th>Birth</th>
        <th>Email</th>
        <th>Is manager</th>
        <th>Manager code</th>
        <th>Department</th>
        <th>Is active</th>
    </tr>
<c:forEach items="${employeeList}" var="emp">
<tr>
        <td class="td-checkbox"><input type="radio" id="${emp.employeeCode}" name="selected-employee" value="${emp.employeeCode}"></td>
        <td id="${emp.employeeCode.concat('_code')}">${emp.employeeCode}</td>
        <td id="${emp.employeeCode.concat('_name')}">${emp.employeeName}</td>
        <td id="${emp.employeeCode.concat('_birth')}">${emp.birth}</td>
        <td id="${emp.employeeCode.concat('_email')}">${emp.email}</td>
        <td class="td-checkbox"><input id="${emp.employeeCode.concat('_isManager')}" type="checkbox" disabled <c:if test="${emp.isManager != null and emp.isManager == 1}">checked</c:if>/></td>
        <td id="${emp.employeeCode.concat('_managerName')}">${emp.managerName}</td>
        <td id="${emp.employeeCode.concat('_departmentName')}">${emp.departmentName}</td>
        <td class="td-checkbox"><input id="${emp.employeeCode.concat('_deleteFlag')}" type="checkbox" disabled <c:if test="${emp.deleteFlag == null or emp.deleteFlag == 0}">checked</c:if>/></td>
    </tr>
</c:forEach>
    <tr>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"></td>
        <td class="border-none"><button id="btn-select" onclick="selectedButtonClick()">Select</button></td>
    </tr>
    </tbody>
</table>
<br>

<script>
    function getCheckedRadioValue(name) {
        // Get all radio buttons with the given name
        let radios = document.getElementsByName(name);
        // Iterate through the radio buttons and check which one is checked
        for (let i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                // Return the value of the checked radio button
                return radios[i].value;
            }
        }
        // Return null or a default value if no radio button is selected
        return null;
    }

    function selectedButtonClick() {
        let selectedValue = getCheckedRadioValue("selected-employee");
        if(!selectedValue) {
            window.alert("Please select employee from the \"Search data\" table")
        } else {
            window.confirm("Selected Employee Code: " + selectedValue)
        }
    }
</script>
</body>
</html>
