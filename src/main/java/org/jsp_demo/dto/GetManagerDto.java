package org.jsp_demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class GetManagerDto {

    private String employeeCode;

    private String employeeName;

    private Boolean selected;
}
