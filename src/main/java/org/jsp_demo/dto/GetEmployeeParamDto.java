package org.jsp_demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class GetEmployeeParamDto {

    private String empName;

    private String managerCode;

    private String departmentCode;

}
