package com.ajx.attendance.login;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ajx.attendance.pojo.Account;
import com.ajx.attendance.service.AttendanceService;
import com.ajx.attendance.service.AuthorityService;
import com.ajx.attendance.utils.BaseDao;

@Controller
@RequestMapping("loginController")
public class LoginManager extends BaseDao{
	public Account account;
	@Resource
	AuthorityService authorityService;
	@Resource 
	AttendanceService attendanceService;
	@RequestMapping("login")
	@ResponseBody
	public boolean login(String username,String password,HttpSession session) {
		if(validate(username, password)){
			session.setAttribute("username", username);
			return true;
		}
		return false;
	}
	public boolean validate(String username,String password){
		String sql = "select * from Account where account = ? and password = ?";
		if(getListBySql(sql, new String[]{username,password}).size()==0){
			return false;
		}
		return true;
	}
	@RequestMapping("logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "login";
	}
	
	@RequestMapping("getUrl")
	@ResponseBody
	public String getUrl(String user){
		String url="";
		String auth=authorityService.getAuth(user);
		String[] arr=auth.split("\\|");
		if(arr.length>0){
			auth=arr[0];
			if("1".equals(auth)){//超级管理员
				url="departmentController/list";
			}else if("4".equals(auth)){//考勤员
				url="work/get";
			}else if("5".equals(auth)){//审核
				url="work/get";
			}else if("6".equals(auth)){//查看考勤
				url="/showAttendance/list";
			}
		}else{
			url="/loginController/logout";
		}
		return url;
	}
}
