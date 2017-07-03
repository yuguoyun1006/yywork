package com.ajx.attendance.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ajx.attendance.filter.Auth;
import com.ajx.attendance.service.AttendanceService;
import com.ajx.attendance.service.AuthorityService;
import com.ajx.attendance.service.DepartmentService;
import com.ajx.attendance.service.ShowAttendanceService;

@Controller
@RequestMapping("showAttendance")
public class ShowAttendanceController {
@Resource
public ShowAttendanceService showService;
@Resource
public AuthorityService authorityService;
@Resource
public DepartmentService departmentService;

@Auth(isSee=true)
@RequestMapping("list")
public ModelAndView list(HttpServletRequest req){
	ModelAndView m=new ModelAndView("/showAttendance/listAttendance");
	HttpSession session=req.getSession();
	String username=(String) session.getAttribute("username");
//	m.addObject(attributeName, attributeValue)
    m.addObject("loginAccount", username);
    m.addObject("auth", authorityService.getAuth(username));
    Date date=new Date();
    SimpleDateFormat  dateStr=new SimpleDateFormat ("yyyy-MM");
    String nowDate=dateStr.format(date);
    m.addObject("nowDate", nowDate);
	return m; 
}
@RequestMapping("getAttendance")
@ResponseBody
public Map<String,Object> getAttendance(HttpServletRequest req,String deptid,String date) throws ParseException{
	HttpSession session=req.getSession();
	String username=(String) session.getAttribute("username");
	List<Map<String, Object>> list=departmentService.getListDepartment(deptid,"");
	List<Map<String,Object>> ls=new ArrayList<Map<String,Object>>();
	Map<String,Object> map=new HashMap<String, Object>();
	boolean flag=false;
	if(list.size()>0&&((list.get(0).get("name")+"").indexOf("集气站")!=-1||(list.get(0).get("name")+"").indexOf("维修队")!=-1)){
		flag=false;
	}else{
	    flag=true;
	}
	ls=showService.getAttendance(deptid, date,flag);
	map.put("flag", flag);
	map.put("data", ls);
	return map;
}

}
