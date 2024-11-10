package org.jsp_demo.controller;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.jsp_demo.dto.Department;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.mapper.DepartmentMapper;
import org.jsp_demo.mapper.EmployeeMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Objects;

@Controller
public class EmployeeController {

    private final EmployeeMapper employeeMapper;
    private final DepartmentMapper departmentMapper;

    public EmployeeController(EmployeeMapper employeeMapper, DepartmentMapper departmentMapper) {
        this.employeeMapper = employeeMapper;
        this.departmentMapper = departmentMapper;
    }

    @RequestMapping("/employee")
    public String viewBooks(Model model, HttpServletRequest request) {
        String name = convertBlankToNull(request.getParameter("empName"));
        String manager = convertBlankToNull(request.getParameter("manager"));
        String department = convertBlankToNull(request.getParameter("department"));
        String search = request.getParameter("search");
        GetEmployeeParamDto param = GetEmployeeParamDto.builder().departmentCode(department).managerCode(manager).empName(name).build();
        // when click search
        if("1".equals(search)) {
            model.addAttribute("employeeList", employeeMapper.getEmployee(param));
        }
        List<Department> departmentList = departmentMapper.getDepartment();
        departmentList.forEach(item -> item.setSelected(Objects.equals(item.getDepartmentCode(), department)));
        model.addAttribute("departmentList", departmentList);
        List<GetManagerDto> managerList = employeeMapper.getEmployeeManager();
        managerList.forEach(item -> item.setSelected(Objects.equals(item.getEmployeeCode(), manager)));
        model.addAttribute("managerList", managerList);
        model.addAttribute("searchName", name);
        return "screen";
    }

    private String convertBlankToNull(String value) {
        if (StringUtils.isBlank(value)) {
            return null;
        }
        return value;
    }
}
