package com.ajx.attendance.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ajx.attendance.dao.AuthorityDao;
import com.ajx.attendance.pojo.Authority;

@Service
public class AuthorityService {

	@Resource
	public AuthorityDao authorityDao;
	
	public List<Authority> list(){
		return authorityDao.list();
	}
	
	public Authority updateAuthority(String id,String authority){
		Authority item=getById(id);
		if(item != null){
			item.setAuthority(authority);
			authorityDao.updateAuthority(item);
		}
		
		return item;
	}
	
	public String getAuth(String account){
		String auth="";
		String sql="select auth from account where account =? and delete_tag=1";
		List<Map<String,Object>> list=null;
		list=authorityDao.getListBySql(sql,new String []{account});
		if(list.size()>0){
			auth=(String) list.get(0).get("auth");
		}
		return auth;
	}
	public Authority getById(String id){
		return authorityDao.getAuthorityById(id);
		
	}
	
	public Authority add(String id,String auth) {
		
		Authority au = new Authority();
		au.setId(id);
		au.setAuthority(auth);
		
		authorityDao.addByEntity(au);
		
		return au;
		
	}
}
