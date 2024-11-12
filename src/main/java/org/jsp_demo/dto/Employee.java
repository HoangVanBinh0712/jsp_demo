package org.jsp_demo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Employee {

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

    private String managerName;

    private String departmentName;

}
