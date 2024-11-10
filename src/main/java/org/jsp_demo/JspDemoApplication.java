package org.jsp_demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan("org.jsp_demo.mapper")
public class JspDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(JspDemoApplication.class, args);
    }

}
