package org.jsp_demo.service;

import org.jsp_demo.dto.Department;
import org.jsp_demo.dto.Employee;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.mapper.DepartmentMapper;
import org.jsp_demo.mapper.EmployeeMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    private final DepartmentMapper departmentMapper;

    private final ModelMapper mapper;

    public DepartmentService(DepartmentMapper departmentMapper, ModelMapper mapper) {
        this.departmentMapper = departmentMapper;
        this.mapper = mapper;
    }

    public List<Department> getDepartment() {
        return departmentMapper.getDepartment();
    }

}
