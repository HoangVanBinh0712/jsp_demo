package org.jsp_demo.repository;

import org.jsp_demo.dto.Employee;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.entity.EmployeeEntity;
import org.jsp_demo.mapper.EmployeeMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmployeeRepository {

    private final EmployeeMapper employeeMapper;


    public EmployeeRepository(EmployeeMapper employeeMapper) {
        this.employeeMapper = employeeMapper;
    }

    public List<Employee> getEmployee(GetEmployeeParamDto param) {
        return employeeMapper.getEmployee(param);
    }

    public List<GetManagerDto> getEmployeeManager() {
        return employeeMapper.getEmployeeManager();
    }
    public int insertEmployee(EmployeeEntity entity) {
        return employeeMapper.insertEmployee(entity);
    }
    public int updateEmployee(EmployeeEntity entity) {
        return employeeMapper.updateEmployee(entity);
    }
    public long getNextSeq() {
        return employeeMapper.getNextSeq();
    }

}
