package com.ajx.attendance.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ajx.attendance.filter.Auth;
import com.ajx.attendance.pojo.Attendance;
import com.ajx.attendance.service.AttendanceService;
import com.ajx.attendance.service.AuthorityService;

@Controller
@RequestMapping("work")
public class AttendanceController {
	@Resource
	public AttendanceService attendanceService;
	@Resource
	public AuthorityService authorityService;
	
	@Auth(isKQ=true,isSH=true)
	@RequestMapping("get")
	public ModelAndView getAllUser(HttpServletRequest req){
			ModelAndView m=null;
			HttpSession session=req.getSession();
			String username=(String) session.getAttribute("username");
			List list=attendanceService.getDeptName(username);
			if(list.size()>0&&((list.get(0)+"").indexOf("集气站")!=-1||(list.get(0)+"").indexOf("维修队")!=-1)){
				m=new ModelAndView("attendance/attendance1");
			}else{
				m=new ModelAndView("attendance/attendance");
			}
		    m.addObject("loginAccount", username);
		    m.addObject("auth", authorityService.getAuth(username));
		    List<Map<String,Object>> list1 = attendanceService.getAllUser(req);
			req.setAttribute("userList", list1);
			return m; 
		
	}
	
	@Auth(isKQ=true,isSH=true)
	@RequestMapping("get1")
	public ModelAndView getAllUser1(HttpServletRequest req){
			ModelAndView m=new ModelAndView("attendance/attendance1");
			HttpSession session=req.getSession();
			String username=(String) session.getAttribute("username");
		    m.addObject("loginAccount", username);
		    m.addObject("auth", authorityService.getAuth(username));
		    List<Map<String,Object>> list = attendanceService.getAllUser(req);
			req.setAttribute("userList", list);
			return m; 
		
	}
	
	
	@RequestMapping("list")
	@ResponseBody
	public List<Map<String,Object>> get(String id,HttpServletRequest req){
		List<Map<String,Object>> list = attendanceService.getAllUser(req);
		return list;
	}
	
	@RequestMapping("isTime")
	@ResponseBody
	public boolean isTime(String date,String deptid){
		return attendanceService.isTime(date, deptid);
	}
	
	@RequestMapping("add")
	@ResponseBody
	public boolean add(String attendance) throws JSONException, ParseException{
		boolean b=false;
		if(!attendance.isEmpty()){
			JSONArray arr=new JSONArray(attendance);
			for(int i=0;i<arr.length();i++){
				JSONObject obj=arr.getJSONObject(i);
				b = attendanceService.add(obj);
			}
		}
		return b;
	}
	@RequestMapping("worklist")
	@ResponseBody
	public List<Map<String,Object>> getWork(String user,String time,HttpServletRequest req){
		List<Map<String,Object>> list = attendanceService.getWork(user,time,req);
		return list;
	}
	@RequestMapping("del")
	@ResponseBody
	public int delete(String id){
		int i = attendanceService.delete(id);
		return i;
	}
	@RequestMapping("getWork")
	@ResponseBody
	public List<Map<String,Object>> getById(String date,HttpServletRequest req){
		List<Map<String,Object>> list = attendanceService.getById(date,req);
		return list;
	}
	@RequestMapping("check")
	@ResponseBody
	public int check(String status,String date,HttpServletRequest req){
		int i = attendanceService.check(status, date,req);
		return i;
	}
}
