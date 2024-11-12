package org.jsp_demo.config.message;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

import java.util.Locale;

@Configuration
public class MessageSourceConfig {

    @Bean
    public MessageSource messageSource() {

        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasenames(
                "classpath:messages/en/messages",
                "classpath:messages/en/system");
        messageSource.setDefaultEncoding("UTF-8");
        messageSource.setDefaultLocale(Locale.US);
        return messageSource;
    }
}
