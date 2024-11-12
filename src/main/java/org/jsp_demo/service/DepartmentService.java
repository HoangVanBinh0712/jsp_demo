package org.jsp_demo.service;

import org.jsp_demo.dto.Department;
import org.jsp_demo.repository.DepartmentRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    private final ModelMapper mapper;

    public DepartmentService(DepartmentRepository departmentRepository, ModelMapper mapper) {
        this.departmentRepository = departmentRepository;
        this.mapper = mapper;
    }

    public List<Department> getDepartment() {
        return departmentRepository.getDepartment();
    }

}
