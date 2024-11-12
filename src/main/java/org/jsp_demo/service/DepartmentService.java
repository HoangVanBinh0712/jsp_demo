package org.jsp_demo.service;

import org.jsp_demo.dto.Employee;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.mapper.DepartmentMapper;
import org.jsp_demo.mapper.EmployeeMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    private final EmployeeMapper employeeMapper;

    private final DepartmentMapper departmentMapper;

    private final ModelMapper mapper;

    public EmployeeService(EmployeeMapper employeeMapper, DepartmentMapper departmentMapper, ModelMapper mapper) {
        this.employeeMapper = employeeMapper;
        this.departmentMapper = departmentMapper;
        this.mapper = mapper;
    }

    public List<Employee> getEmployee(GetEmployeeParamDto param) {
        return employeeMapper.getEmployee(param);
    }

    public List<GetManagerDto> getEmployeeManager() {
        return employeeMapper.getEmployeeManager();
    }
}
