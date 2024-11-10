package org.jsp_demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
@Builder
public class Department {

    private String departmentCode;

    private String departmentName;

    private String description;

    private String address;

    private Integer deleteFlag;

    private String createdBy;

    private Timestamp createdDatetime;

    private String updatedBy;

    private Timestamp updatedDatetime;

    private Boolean selected;

}
