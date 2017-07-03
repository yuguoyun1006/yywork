package com.ajx.attendance.filter;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ajx.attendance.service.AuthorityService;

public class AuthInterceptor implements HandlerInterceptor{
	
	@Resource 
	AuthorityService authorityService;

	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public boolean preHandle(HttpServletRequest req, HttpServletResponse res,
			Object handler) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String username=session.getAttribute("username")+"";
		HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod(); 
        Auth auth=method.getAnnotation(Auth.class);
        if(username!=null&&!"null".equals(username)){
        	 String ars=authorityService.getAuth(username);
        	 if(ars==null||StringUtils.isEmpty(ars)){
        		 return false;
        	 }
        	 String[] arr=ars.split("\\|");
        	 List<String> list=Arrays.asList(arr);
             if(auth!=null){
             	if(auth.isAdmin()&&list.contains("1")){
             		return true;
             	}else if(auth.isKQ()&&list.contains("4")){
             		return true;
             	}else if(auth.isSH()&&list.contains("5")){
             		return true;
             	}else if(auth.isSee()&&list.contains("6")){
             		return true;
             	}else{
             		res.sendRedirect("/loginController/logout");
            		return false;
             	}
             }
        }
            return true;
	}

}
