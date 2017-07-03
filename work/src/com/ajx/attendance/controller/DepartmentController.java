package com.ajx.attendance.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ajx.attendance.filter.Auth;
import com.ajx.attendance.pojo.Department;
import com.ajx.attendance.service.AuthorityService;
import com.ajx.attendance.service.DepartmentService;


@Controller
@RequestMapping("departmentController")
public class DepartmentController {
@Resource
public DepartmentService departmentService;
@Resource
public AuthorityService authorityService;
@Auth(isAdmin=true)
@RequestMapping("list")
public ModelAndView listDepartment(HttpServletRequest req){
	ModelAndView m=new ModelAndView("/department/listDepartment");
	HttpSession session=req.getSession();
	String username=(String) session.getAttribute("username");
//	m.addObject(attributeName, attributeValue)
    m.addObject("loginAccount", username);
    m.addObject("auth", authorityService.getAuth(username));
	return m;
}	
	@RequestMapping("dtree")
	@ResponseBody
	public List<Map<String,Object>> deptTree(HttpServletResponse res){
		res.setHeader("Access-Control-Allow-Origin", "*");
		List<Map<String,Object>> list = departmentService.deptTree();
		return list;
	}
	@RequestMapping("userTree")
	@ResponseBody
	public List<Map<String,Object>> userTree(HttpServletResponse res,String deptId){
		res.setHeader("Access-Control-Allow-Origin", "*");
		List<Map<String,Object>> list = departmentService.usertree(deptId);
		return list;
	}
	
	@Auth(isAdmin=true)
	@RequestMapping("tree")
	public String dTree(){
		return "department/listDepartment";
	}
	
	@Auth(isAdmin=true)
	@RequestMapping("add")
	public ModelAndView add(){
		ModelAndView m=new ModelAndView("/department/addDepartment");
		return m;
	}
	
	@RequestMapping("saveDepartment")
	@ResponseBody
	public Department saveDepartment(String itemStr,HttpServletResponse res) throws Exception{
		res.setHeader("Access-Control-Allow-Origin", "*");
		return departmentService.saveDepartment(itemStr);
	}
@RequestMapping("getJsonListDepartmentBySql")
@ResponseBody
public List<Map<String,Object>> getListYsDepartment(String deptid,String name,HttpServletResponse res) throws UnsupportedEncodingException{
	res.setHeader("Access-Control-Allow-Origin", "*");
	name=URLDecoder.decode(name,"UTF-8");
	List<Map<String,Object>> listDepartment=departmentService.getListDepartment(deptid,name);
	return  listDepartment;
}
@RequestMapping("getDeptById")
@ResponseBody
public Department getDeptById(String id,HttpServletResponse res){
	res.setHeader("Access-Control-Allow-Origin", "*");
	return  departmentService.getDeptById(id);
}
@RequestMapping("deleteDept")
@ResponseBody
public boolean deleteDept(String id,HttpServletResponse res){
	res.setHeader("Access-Control-Allow-Origin", "*");
	return departmentService.deleteDept(id);
}


@RequestMapping("trim")
@ResponseBody
public boolean trimDept(String id,int pid,HttpServletResponse res){
	res.setHeader("Access-Control-Allow-Origin", "*");
	int newpid=Integer.valueOf(pid);
	return departmentService.trimDept(id,newpid);
}
}
