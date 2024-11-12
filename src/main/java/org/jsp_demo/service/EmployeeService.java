package org.jsp_demo.service;

import org.jsp_demo.dto.Employee;
import org.jsp_demo.dto.GetEmployeeParamDto;
import org.jsp_demo.dto.GetManagerDto;
import org.jsp_demo.entity.EmployeeEntity;
import org.jsp_demo.repository.EmployeeRepository;
import org.modelmapper.ModelMapper;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class EmployeeService {
    private final EmployeeRepository employeeRepository;

    private final ModelMapper mapper;

    public EmployeeService(EmployeeRepository employeeRepository, ModelMapper mapper) {
        this.employeeRepository = employeeRepository;
        this.mapper = mapper;
    }

    public List<Employee> getEmployee(GetEmployeeParamDto param) {
        return employeeRepository.getEmployee(param);
    }

    public List<GetManagerDto> getEmployeeManager() {
        return employeeRepository.getEmployeeManager();
    }

    @Transactional
    public int insertEmployee(EmployeeEntity entity) {
        String nextCode = generateNextEmployeeCode();
        entity.setEmployeeCode(nextCode);
        entity.setCreatedBy("Admin");
        entity.setCreatedDatetime(Timestamp.valueOf(LocalDateTime.now()));
        return employeeRepository.insertEmployee(entity);
    }

    @Transactional
    public int updateEmployee(EmployeeEntity entity) {
        entity.setUpdatedBy("Admin");
        entity.setUpdatedDatetime(Timestamp.valueOf(LocalDateTime.now()));
        return employeeRepository.updateEmployee(entity);
    }

    public String generateNextEmployeeCode() {
        long nextSeq = employeeRepository.getNextSeq();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String ymd = LocalDateTime.now().format(dateTimeFormatter);
        String numStr = String.format("%012d", nextSeq);
        return ymd + numStr;
    }
}
