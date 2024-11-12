package org.jsp_demo.controller;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.jsp_demo.entity.EmployeeEntity;
import org.jsp_demo.response.ApiResponse;
import org.jsp_demo.dto.Department;
import org.jsp_demo.dto.Employee;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.mapper.DepartmentMapper;
import org.jsp_demo.mapper.EmployeeMapper;
import org.jsp_demo.request.EmployeeForm;
import org.jsp_demo.service.DepartmentService;
import org.jsp_demo.service.EmployeeService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping()
public class EmployeeController {

    private final ModelMapper mapper;

    private final EmployeeService employeeService;
    private final DepartmentService departmentService;

    public EmployeeController(ModelMapper mapper, EmployeeService employeeService, DepartmentService departmentService) {
        this.mapper = mapper;
        this.employeeService = employeeService;
        this.departmentService = departmentService;
    }

    @GetMapping("/employee")
    public String view(Model model, HttpServletRequest request) {
        String name = convertBlankToNull(request.getParameter("empName"));
        String manager = convertBlankToNull(request.getParameter("manager"));
        String department = convertBlankToNull(request.getParameter("department"));
        String search = request.getParameter("search");
        GetEmployeeParamDto param = GetEmployeeParamDto.builder().departmentCode(department).managerCode(manager).empName(name).build();
        // when click search
        if ("1".equals(search)) {
            model.addAttribute("employeeList", getEmployee(param));
        } else {
            model.addAttribute("employeeList", new ArrayList<>());
        }
        setUpSelect(model, department, manager);
        model.addAttribute("searchName", name);
        return "screen";
    }

    private List<Employee> getEmployee(GetEmployeeParamDto param) {
        return employeeService.getEmployee(param);
    }

    @PostMapping("/employee")
    @ResponseBody
    public ApiResponse<?> saveOrEdit(@Valid @ModelAttribute EmployeeForm employeeForm) {
        ApiResponse<Object> dataResponse = new ApiResponse<>();
        dataResponse.setData(employeeForm);
        return dataResponse;
    }

    private String convertBlankToNull(String value) {
        if (StringUtils.isBlank(value)) {
            return null;
        }
        return value;
    }

    @GetMapping("/employee-form")
    public String showEmployeeForm(Model model, HttpServletRequest request) {
        String empCode = convertBlankToNull(request.getParameter("empCode"));
        String manager = "";
        String department = "";
        if (StringUtils.isNotBlank(empCode)) {
            GetEmployeeParamDto param = GetEmployeeParamDto.builder().empCode(empCode).build();
            Employee employee = getEmployee(param).stream().findAny().orElse(
                    Employee.builder().build()
            );
            manager = employee.getManagerCode();
            department = employee.getDepartmentCode();
            model.addAttribute("employeeForm", mapper.map(employee, EmployeeForm.class));
        } else {
            model.addAttribute("employeeForm", EmployeeForm.builder().build());
        }

        setUpSelect(model, department, manager);
        return "employee-form";
    }

    private void setUpSelect(Model model, String department, String manager) {
        List<Department> departmentList = departmentService.getDepartment();
        departmentList.forEach(item -> item.setSelected(Objects.equals(item.getDepartmentCode(), department)));
        model.addAttribute("departmentList", departmentList);
        List<GetManagerDto> managerList = employeeService.getEmployeeManager();
        managerList.forEach(item -> item.setSelected(Objects.equals(item.getEmployeeCode(), manager)));
        model.addAttribute("managerList", managerList);
    }

    @PostMapping("/employee-form")
    public String submitEmployeeForm(@Valid @ModelAttribute("employeeForm") EmployeeForm employeeForm,
                                     BindingResult bindingResult,
                                     Model model) {
        setUpSelect(model, employeeForm.getDepartmentCode(), employeeForm.getManagerCode());

        if (bindingResult.hasErrors()) {
            return "employee-form";
        }
        EmployeeEntity entity = mapper.map(employeeForm, EmployeeEntity.class);
        entity.setBirth(Date.valueOf(employeeForm.getBirth()));
        if(StringUtils.isNotBlank(employeeForm.getEmployeeCode())) {
            // update
            employeeService.updateEmployee(entity);
        } else {
            // insert
            employeeService.insertEmployee(entity);
        }
        return "redirect:/employee";
    }
}
