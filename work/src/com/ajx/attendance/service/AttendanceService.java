package com.ajx.attendance.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.ajx.attendance.dao.AttendanceDao;
import com.ajx.attendance.pojo.Attendance;
import com.ajx.attendance.pojo.Work;

@Service
public class AttendanceService {
	@Resource
	public AttendanceDao attendanceDao;
	public List<Map<String,Object>> getAllUser(HttpServletRequest req){
		return attendanceDao.getAllUser(req);
	}
	
	public boolean isTime(String date,String deptid){
		return attendanceDao.isTime(date,deptid);
	}
	
	public boolean add(JSONObject json) throws JSONException, ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//		JSONObject json = new JSONObject(attendance);
		Work attendance2 = new Work();
		Date date=sdf.parse(json.getString("attendance_date"));
		if(StringUtils.isEmpty(json.getString("id"))){
			attendance2.setId(null);
			attendance2.setName(json.getString("username"));
			attendance2.setDayWork(json.getString("dayWork"));
			attendance2.setA1(json.getString("a1"));
			attendance2.setA2(json.getString("a2"));
			attendance2.setA3(json.getString("a3"));
			attendance2.setA4(json.getString("a4"));
			attendance2.setA5(json.getString("a5"));
			attendance2.setA6(json.getString("a6"));
			attendance2.setA7(json.getString("a7"));
			attendance2.setA8(json.getString("a8"));
			attendance2.setA9(json.getString("a9"));
			attendance2.setA10(json.getString("a10"));
			attendance2.setA11(json.getString("a11"));
			attendance2.setA12(json.getString("a12"));
			attendance2.setA13(json.getString("a13"));
			attendance2.setA14(json.getString("a14"));
			attendance2.setA15(json.getString("a15"));
			attendance2.setA16(json.getString("a16"));
			attendance2.setA17(json.getString("a17"));
			attendance2.setA18(json.getString("a18"));
			attendance2.setA19(json.getString("a19"));
			attendance2.setA20(json.getString("a20"));
			attendance2.setA21(json.getString("a21"));
			attendance2.setA22(json.getString("a22"));
			attendance2.setA23(json.getString("a23"));
			attendance2.setA24(json.getString("a24"));
			attendance2.setA25(json.getString("a25"));
			attendance2.setA26(json.getString("a26"));
			attendance2.setA27(json.getString("a27"));
			attendance2.setA28(json.getString("a28"));
			attendance2.setA29(json.getString("a29"));
			attendance2.setA30(json.getString("a30"));
			attendance2.setA31(json.getString("a31"));
			attendance2.setStatus("0");
			attendance2.setDeptId(Integer.parseInt(json.getString("dept_id")));
			attendance2.setEmpNo(json.getString("jobnumber"));
			attendance2.setAttendanceDate(date);
			attendance2.setRemark(json.getString("remark"));
			attendance2.setZhongBan(json.getString("zhongBan"));
			attendance2.setShenBan(json.getString("shenBan"));
			attendance2.setUpdateTime(new Date());
			return attendanceDao.addByEntity(attendance2);
		}else{
			Work attendance3 = attendanceDao.getWorkById(json.getString("id"));
			attendance3.setA1(json.getString("a1"));
			attendance3.setA2(json.getString("a2"));
			attendance3.setA3(json.getString("a3"));
			attendance3.setA4(json.getString("a4"));
			attendance3.setA5(json.getString("a5"));
			attendance3.setA6(json.getString("a6"));
			attendance3.setA7(json.getString("a7"));
			attendance3.setA8(json.getString("a8"));
			attendance3.setA9(json.getString("a9"));
			attendance3.setA10(json.getString("a10"));
			attendance3.setA11(json.getString("a11"));
			attendance3.setA12(json.getString("a12"));
			attendance3.setA13(json.getString("a13"));
			attendance3.setA14(json.getString("a14"));
			attendance3.setA15(json.getString("a15"));
			attendance3.setA16(json.getString("a16"));
			attendance3.setA17(json.getString("a17"));
			attendance3.setA18(json.getString("a18"));
			attendance3.setA19(json.getString("a19"));
			attendance3.setA20(json.getString("a20"));
			attendance3.setA21(json.getString("a21"));
			attendance3.setA22(json.getString("a22"));
			attendance3.setA23(json.getString("a23"));
			attendance3.setA24(json.getString("a24"));
			attendance3.setA25(json.getString("a25"));
			attendance3.setA26(json.getString("a26"));
			attendance3.setA27(json.getString("a27"));
			attendance3.setA28(json.getString("a28"));
			attendance3.setA29(json.getString("a29"));
			attendance3.setA30(json.getString("a30"));
			attendance3.setA31(json.getString("a31"));
			if(!"999".equals(json.getString("status"))){
				attendance3.setStatus(json.getString("status"));
			}
			attendance3.setName(json.getString("username"));
			attendance3.setDayWork(json.getString("dayWork"));
			attendance3.setZhongBan(json.getString("zhongBan"));
			attendance3.setShenBan(json.getString("shenBan"));
			attendance3.setAttendanceDate(sdf.parse(json.getString("attendance_date")));
			attendance3.setRemark(json.getString("remark"));
			attendance3.setUpdateTime(new Date());
			return attendanceDao.updateByEntity(attendance3);
		}
		
	}
	public List<Map<String,Object>> getWork(String user,String time,HttpServletRequest req){
		return attendanceDao.getWork(user,time,req);
	}
	public int delete(String id){
		return attendanceDao.delete(id);
	}
	public List<Map<String,Object>> getById(String id,HttpServletRequest req){
		return attendanceDao.getById(id,req);
	}
	public int check(String status,String date,HttpServletRequest req){
		return attendanceDao.check(status, date,req);
	}
	
	public List getDeptName(String account){
		return attendanceDao.getDeptName(account);
	}
}
