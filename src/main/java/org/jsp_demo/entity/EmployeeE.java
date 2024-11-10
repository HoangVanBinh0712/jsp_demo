package org.jsp_demo.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
@Builder
public class EmployeeE {

    private String employeeCode;

    private String employeeName;

    private Date birth;

    private String email;

    private Integer isManager;

    private String managerCode;

    private String departmentCode;

    private Integer deleteFlag;

    private String createdBy;

    private Timestamp createdDatetime;

    private String updatedBy;

    private Timestamp updatedDatetime;

}
