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
            font-size: 18px;
        }

        table {
            border-collapse: collapse;
            font-family: Arial, sans-serif;
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

        .input-text:focus, .selection:focus {
            border-color: #0b57d0;
        }

        .td-checkbox {
            text-align: center;
        }

        .border-none {
            border: none;
            text-align: right;
        }

        tbody tr button {
            text-align: center;
            padding: 7px 12px;
        }

        .btn-submit {
            background-color: #1a73e8;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .wrapper {
            padding: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .empty-col {
            padding: 15px;
        }
    </style>
</head>
<body>
<div class="wrapper">
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
                        <option value="${dept.departmentCode}"
                                <c:if test="${dept.selected == true}">selected</c:if>>${dept.departmentName}</option>
                    </c:forEach>
                </select></td>
                <th>Manager</th>
                <td><select class="selection" name="manager">
                    <option value=""></option>
                    <c:forEach items="${managerList}" var="emp">
                        <option value="${emp.employeeCode}"
                                <c:if test="${emp.selected == true}">selected</c:if>>${emp.employeeName}</option>
                    </c:forEach>
                </select></td>
            </tr>
            <tr>
                <td class="border-none"></td>
                <td class="border-none"></td>
                <td class="border-none"></td>
                <td class="border-none">
                    <button class="btn-submit" id="btn-submit" type="submit">Search</button>
                </td>
            </tr>
        </form>

        </tbody>
    </table>
</div>
<br>
<div class="wrapper">
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
            <th>Manager</th>
            <th>Manager code</th>
            <th>Department</th>
            <th>Active</th>
        </tr>
        <c:if test="${employeeList == null || (employeeList != null and employeeList.size() == 0)}">
            <tr>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
            </tr>
            <tr>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
            </tr>
            <tr>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
                <td class="empty-col"></td>
            </tr>
        </c:if>
        <c:forEach items="${employeeList}" var="emp">
            <tr>
                <td class="td-checkbox"><a
                        href="${pageContext.request.contextPath}/employee-form?empCode=${emp.employeeCode}">Edit</a>
                </td>
                <td id="${emp.employeeCode.concat('_code')}">${emp.employeeCode}</td>
                <td id="${emp.employeeCode.concat('_name')}">${emp.employeeName}</td>
                <td id="${emp.employeeCode.concat('_birth')}">${emp.birth}</td>
                <td id="${emp.employeeCode.concat('_email')}">${emp.email}</td>
                <td class="td-checkbox"><input id="${emp.employeeCode.concat('_isManager')}" type="checkbox"
                                               disabled
                                               <c:if test="${emp.isManager != null and emp.isManager == 1}">checked</c:if>/>
                </td>
                <td id="${emp.employeeCode.concat('_managerName')}">${emp.managerName}
                    <input type="hidden" value="${emp.managerCode}" id="${emp.employeeCode.concat('_managerCode')}">
                </td>
                <td id="${emp.employeeCode.concat('_departmentName')}">${emp.departmentName}
                    <input type="hidden" value="${emp.departmentCode}"
                           id="${emp.employeeCode.concat('_departmentCode')}">
                </td>
                <td class="td-checkbox"><input id="${emp.employeeCode.concat('_deleteFlag')}" type="checkbox"
                                               disabled
                                               <c:if test="${emp.deleteFlag == null or emp.deleteFlag == 0}">checked</c:if>/>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td class="border-none" colspan="99">
                <button id="btn-new" class="btn-submit" onclick="btnNewClick()">New</button>
                <button id="btn-select" class="btn-submit" onclick="selectedButtonClick()">Select</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<br>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function getCheckedRadioValue(name) {
        // Get all radio buttons with the given name
        let radios = $("[name^='" + name + "']");
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

    // use for input
    function getVal(data) {
        return data == null ? null : data.val()
    }

    // use for input type check
    function getTextCheckbox(data) {
        return data == null ? null : data.prop("checked")
    }

    // use for others
    function getText(data) {
        return data == null ? null : data.text()
    }

    $(document).ready(function () {
        let selectedValue = getCheckedRadioValue("selected-employee");
        if (selectedValue) {
            selectedButtonClick()
        }
    });

    function btnNewClick() {
        window.open(`${pageContext.request.contextPath}/employee-form`)
    }

    function selectedButtonClick() {
        // let selectedValue = getCheckedRadioValue("selected-employee");
        //
        // if (!selectedValue) {
        //     window.alert("Please select employee from the \"Search data\" table")
        // } else {
        // let empCodeElement = getText($("[id^='" + selectedValue + "_code']"));
        // let empNameElement = getText($("[id^='" + selectedValue + "_name']"));
        // let empBirthElement = getText($("[id^='" + selectedValue + "_birth']"));
        // let empEmailElement = getText($("[id^='" + selectedValue + "_email']"));
        // let empIsManagerElement = getTextCheckbox($("[id^='" + selectedValue + "_isManager']"));
        // let empManagerCodeElement = getVal($("[id^='" + selectedValue + "_managerCode']"));
        // let empDepartmentCodeElement = getVal($("[id^='" + selectedValue + "_departmentCode']"));
        // let empDeleteFlagElement = getTextCheckbox($("[id^='" + selectedValue + "_deleteFlag']"));
        //
        // let inputEmpCode = $("#form-employee-employeeCode");
        // let inputEmpName = $("#form-employee-employeeName");
        // let inputEmpBirth = $("#form-employee-birth");
        // let inputEmpEmail = $("#form-employee-email");
        // let inputEmpIsManager = $("#form-employee-isManager");
        // let inputEmpManagerSelect = $("#form-employee-managerSelect");
        // let inputEmpDepartmentSelect = $("#form-employee-departmentSelect");
        // let inputEmpDeleteFlag = $("#form-employee-isActive");
        //
        // inputEmpCode.val(empCodeElement)
        // inputEmpName.val(empNameElement)
        // inputEmpBirth.val(empBirthElement)
        // inputEmpEmail.val(empEmailElement)
        // inputEmpIsManager.prop('checked', empIsManagerElement)
        // inputEmpManagerSelect.val(empManagerCodeElement)
        // inputEmpDepartmentSelect.val(empDepartmentCodeElement)
        // inputEmpDeleteFlag.prop('checked', empDeleteFlagElement)
        // }
    }

    function btnSaveEditClick() {

        // let inputEmpCode = getVal($("#form-employee-employeeCode"));
        // let inputEmpName = getVal($("#form-employee-employeeName"));
        // let inputEmpBirth = getVal($("#form-employee-birth"));
        // let inputEmpEmail = getVal($("#form-employee-email"));
        // let inputEmpIsManager = getCheckedRadioValue($("#form-employee-isManager"));
        // let inputEmpDeleteFlag = getCheckedRadioValue($("#form-employee-isActive"));
        // let inputEmpManagerSelect = getVal($("#form-employee-managerSelect"));
        // let inputEmpDepartmentSelect = getVal($("#form-employee-departmentSelect"));
        //
        // const requestParam = {
        //     employeeCode: inputEmpCode,
        //     employeeName: inputEmpName,
        //     birth: inputEmpBirth,
        //     email: inputEmpEmail,
        //     isManager: inputEmpIsManager,
        //     managerCode: inputEmpManagerSelect,
        //     departmentCode: inputEmpDepartmentSelect,
        //     deleteFlag: inputEmpDeleteFlag
        // }
        //
        // fetch('/employee', {
        //     method: 'POST',
        //     headers: {
        //         'Content-Type': 'application/json',
        //     },
        //     body: JSON.stringify(requestParam)
        // })
        //     .then(response => {
        //         if (!response.ok) {
        //             throw new Error('Network response was not ok');
        //         }
        //         return response.json(); // Parse the JSON from the response
        //     })
        //     .then(data => {
        //         console.log('Received data:', data);
        //         // Do something with the received data (JSON)
        //     })
        //     .catch(error => {
        //         console.error('There was a problem with the fetch operation:', error);
        //     });
    }
</script>
</body>
</html>
