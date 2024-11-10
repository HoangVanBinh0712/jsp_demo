package org.jsp_demo.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.jsp_demo.dto.Department;

import java.util.List;

@Mapper
public interface DepartmentMapper {
    List<Department> getDepartment();
}