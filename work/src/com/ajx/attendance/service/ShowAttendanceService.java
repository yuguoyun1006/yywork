package com.ajx.attendance.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.ajx.attendance.dao.ShowAttendanceDao;

@Service
public class ShowAttendanceService {
@Resource
public ShowAttendanceDao showDao;


public List<Map<String,Object>> getAttendance(String deptid,String date,boolean flag) throws ParseException{
	return showDao.getAttendance(deptid, date,flag);
}
}
