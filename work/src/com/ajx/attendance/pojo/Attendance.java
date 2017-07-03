package com.ajx.attendance.pojo;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Attendance entity. @author MyEclipse Persistence Tools
 */

public class Attendance implements java.io.Serializable {

	// Fields

	private String id;
	private String name;
	private String afterStatus;
	private String morStatus;
	private Date attendanceDate;
	private String remark;
	private Integer deptId;
	private String empNo;
	private String overtime;
	private String overtimeTime;
	private String nightshift;
	private String nightshiftTie;
	private Date createTime;
	private Date updateTime;

	// Constructors

	/** default constructor */
	public Attendance() {
	}

	/** minimal constructor */
	public Attendance(String id) {
		this.id = id;
	}

	/** full constructor */
	public Attendance(String id, String name, String afterStatus,
			String morStatus, Timestamp attendanceDate, String remark,
			Integer deptId, String empNo, String overtime, String overtimeTime,
			String nightshift, String nightshiftTie, Timestamp createTime,
			Timestamp updateTime) {
		this.id = id;
		this.name = name;
		this.afterStatus = afterStatus;
		this.morStatus = morStatus;
		this.attendanceDate = attendanceDate;
		this.remark = remark;
		this.deptId = deptId;
		this.empNo = empNo;
		this.overtime = overtime;
		this.overtimeTime = overtimeTime;
		this.nightshift = nightshift;
		this.nightshiftTie = nightshiftTie;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAfterStatus() {
		return this.afterStatus;
	}

	public void setAfterStatus(String afterStatus) {
		this.afterStatus = afterStatus;
	}

	public String getMorStatus() {
		return this.morStatus;
	}

	public void setMorStatus(String morStatus) {
		this.morStatus = morStatus;
	}

	public Date getAttendanceDate() {
		return this.attendanceDate;
	}

	public void setAttendanceDate(Date attendanceDate) {
		this.attendanceDate = attendanceDate;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDeptId() {
		return this.deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getEmpNo() {
		return this.empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getOvertime() {
		return this.overtime;
	}

	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}

	public String getOvertimeTime() {
		return this.overtimeTime;
	}

	public void setOvertimeTime(String overtimeTime) {
		this.overtimeTime = overtimeTime;
	}

	public String getNightshift() {
		return this.nightshift;
	}

	public void setNightshift(String nightshift) {
		this.nightshift = nightshift;
	}

	public String getNightshiftTie() {
		return this.nightshiftTie;
	}

	public void setNightshiftTie(String nightshiftTie) {
		this.nightshiftTie = nightshiftTie;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}