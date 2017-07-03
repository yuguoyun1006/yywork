package com.ajx.attendance.filter;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Auth {
boolean isAdmin() default false;
boolean isKQ() default false;
boolean isSH() default false;
boolean isSee() default false;
}
