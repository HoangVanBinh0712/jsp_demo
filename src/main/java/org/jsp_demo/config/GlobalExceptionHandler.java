package org.jsp_demo.config;

import io.micrometer.common.util.StringUtils;
import lombok.extern.log4j.Log4j2;
import org.jsp_demo.response.ApiError;
import org.jsp_demo.response.ApiResponse;
import org.jsp_demo.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.HandlerMethod;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

@ControllerAdvice
@Log4j2
public class GlobalExceptionHandler {


    @Autowired
    private MessageSource messageSource;

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Object> handleMethodArgumentNotValidException(MethodArgumentNotValidException ex, HandlerMethod handlerMethod) {
        List<ApiError> errors = new ArrayList<>();
        ex.getFieldErrors().forEach(fieldError -> {
            ApiError error = handleErrorArgument(handlerMethod, fieldError);
            errors.add(error);
        });
        return new ResponseEntity<>(new ApiResponse<>(errors), HttpStatus.BAD_REQUEST);
    }

    private ApiError handleErrorArgument(HandlerMethod handlerMethod, FieldError fieldError) {
        ApiError error = new ApiError();
        String fieldNameError = handlerMethod.getBeanType().getSimpleName()
                + Constants.DOT + fieldError.getObjectName()
                + Constants.DOT + removeIndexFromString(fieldError.getField());
        String fieldNameMessage;
        try {
            fieldNameMessage = messageSource.getMessage(fieldNameError, null, LocaleContextHolder.getLocale());
        } catch (Exception e) {
            fieldNameMessage = fieldError.getField();
        }
        String message = fieldError.getDefaultMessage();
        setMessage(error, message, new Object[] { fieldNameMessage });
        error.setCode(fieldError.getField());
        return error;
    }

    public static String removeIndexFromString(String inputString) {
        // Construct the regular expression pattern to match [2] or any other index
        String regex = "\\[\\d+\\]";

        // Replace all occurrences of the matched pattern with an empty string
        return inputString.replaceAll(regex, Constants.EMPTY);
    }

    private void setMessage(ApiError error, String message, Object[] param) {
        if (StringUtils.isNotBlank(message)) {
            try {
                MessageFormat messageFormat = new MessageFormat(message);
                error.setMessage(messageFormat.format(param));
            } catch (Exception e) {
                log.error(e);
            }
        }
    }
}
