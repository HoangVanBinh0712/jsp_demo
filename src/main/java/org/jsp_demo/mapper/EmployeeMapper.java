package org.jsp_demo.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.jsp_demo.dto.Employee;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.entity.EmployeeEntity;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    List<Employee> getEmployee(@Param("param") GetEmployeeParamDto param);
    List<GetManagerDto> getEmployeeManager();
    int insertEmployee(EmployeeEntity entity);
    int updateEmployee(EmployeeEntity entity);
    int getNextSeq();

}