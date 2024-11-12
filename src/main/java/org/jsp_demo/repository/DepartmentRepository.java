package org.jsp_demo.repository;

import org.jsp_demo.dto.Department;
import org.jsp_demo.mapper.DepartmentMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Repository
public class DepartmentRepository {

    private final DepartmentMapper departmentMapper;


    public DepartmentRepository(DepartmentMapper departmentMapper) {
        this.departmentMapper = departmentMapper;
    }

    public List<Department> getDepartment() {
        return departmentMapper.getDepartment();
    }

}
