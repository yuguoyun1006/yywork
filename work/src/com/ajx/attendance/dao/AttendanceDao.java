package com.ajx.attendance.dao;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import com.ajx.attendance.pojo.Attendance;
import com.ajx.attendance.pojo.Work;
import com.ajx.attendance.utils.BaseDao;
@Repository
public class AttendanceDao extends BaseDao{
	
	public boolean isTime(String date,String deptid){
		List<Map<String,Object>> list=null;
		String year=date.substring(0, date.indexOf("-"));
		int ye=Integer.parseInt(year);
		String month=date.substring(date.indexOf("-")+1,date.length());
		int mon=Integer.parseInt(month);
		String sql="select * from vw_work where (year(attendance_date) = ? and month(attendance_date)=? and dept_id=?) ";
		list=getListBySql(sql, new String[]{String.valueOf(ye),String.valueOf(mon),deptid});
		if(list.size()>0){
			return false;
		}else{
			return true;
		}
	}
	
	
	public List<Map<String,Object>> getAllUser(HttpServletRequest req){
		String sql = "select id,username,dept_id,jobnumber from user where dept_id = ? and delete_tag = 1";
		List<Map<String,Object>>list = getListBySql(sql, new String[]{getDeptId(req).get(0)+""});
		return list;
	}
	//添加考勤
	public boolean add(Attendance attendance){
		return addByEntity(attendance);
	}
	//编辑考勤
	public boolean update(Attendance attendance){
		return updateByEntity(attendance);
	}
	public List<Map<String,Object>> getWork(String user,String time,HttpServletRequest req){
		String sql="";
		List<Map<String,Object>> list=null;
		if((user==null||user.isEmpty())&&(time==null||time.isEmpty())){
			sql="select * from work where dept_id = ? order by attendance_date,emp_no,name,day_work desc";
			list = getListBySql(sql, new String[]{getDeptId(req).get(0)+""});
		}else if(!(user==null||user.isEmpty())&&(time==null||time.isEmpty())){
			sql = "select * from work where dept_id = ? and name like ? order by attendance_date,emp_no,name,day_work desc";
			list = getListBySql(sql, new String[]{getDeptId(req).get(0)+"","%"+user+"%"});
		}else if((user==null||user.isEmpty())&&!(time==null||time.isEmpty())){
			int year=Integer.parseInt(time.substring(0, time.indexOf("-")));
			int month=Integer.parseInt(time.substring(time.indexOf("-")+1)); 
			sql = "select * from work where dept_id = ? and year(attendance_date) = ? and month(attendance_date)=? order by attendance_date,emp_no,name,day_work desc";
			list = getListBySql(sql, new String[]{getDeptId(req).get(0)+"",String.valueOf(year),String.valueOf(month)});
		}else{
			int year=Integer.parseInt(time.substring(0, time.indexOf("-")));
			int month=Integer.parseInt(time.substring(time.indexOf("-")+1)); 
			sql = "select * from work where dept_id = ? and name like ? and year(attendance_date) = ? and month(attendance_date)=? order by attendance_date,emp_no,name,day_work desc";
			list = getListBySql(sql, new String[]{getDeptId(req).get(0)+"","%"+user+"%",String.valueOf(year),String.valueOf(month)});
		}
		return list;
	}
	public List getDeptId(HttpServletRequest req){
		HttpSession session=req.getSession();
		String username=(String) session.getAttribute("username");
		String sql = "select dept_id from user where account = ?";
		return getListEntityBySql(sql, new String[]{username});
	}
	public List getDeptName(String username){
		String sql="select dept_name from account_user_dept where account = ?";
		return getListEntityBySql(sql, new String[]{username});
	}
	public int delete(String id){
		Work work=getWorkById(id);
		String emp_no=work.getEmpNo();
		SimpleDateFormat sdf=new SimpleDateFormat("YYYY-MM");
		String date=sdf.format(work.getAttendanceDate());
		String sql = "delete from work where emp_no = ? and DATE_FORMAT(attendance_date,'%Y-%m') = ?";
		int i=updateBySql(sql,new String[]{emp_no,date});
    	return i;
	}
	public Work getWorkById(String id){
		Work work=null;
		if(id.isEmpty()){
		}else{
			work=(Work)getEntityById(Work.class,id);
		}
		return work;
	}
	public List<Map<String,Object>> getById(String id,HttpServletRequest req){
		String sql = "select * from work where DATE_FORMAT(attendance_date,'%Y-%m') = ? and dept_id=? order by emp_no,name,day_work desc";
		List<Map<String,Object>> list = getListBySql(sql, new String[]{id,getDeptId(req).get(0)+""});
		return list;
	}
	public int check(String status,String date,HttpServletRequest req){
		String sql = "update work set status = ? where DATE_FORMAT(attendance_date,'%Y-%m') = ? and dept_id=?";
		int i = updateBySql(sql, new String[]{status,date,getDeptId(req).get(0)+""});
		return i;
	}
}
