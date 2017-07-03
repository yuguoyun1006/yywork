package com.ajx.attendance.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.ajx.attendance.dao.AccountDao;
import com.ajx.attendance.dao.UserDao;
import com.ajx.attendance.pojo.Account;
import com.ajx.attendance.pojo.User;

@WebService
@SOAPBinding(style = Style.RPC)
@Service
public class UserService {
	@Resource
	private UserDao userdao;

	@Resource 
	private AccountDao accountDao;
	public List<User> list(String name) {
		return userdao.list(name);
	}
	public List<Map<String,Object>> list1(String id,String name) {
		return userdao.list1(id,name);
	}
	public boolean del(String id) {
		return userdao.del(id);
	}
/**
 * 添加编辑用户
 * @param user
 * @return
 * @throws JSONException
 * @throws ParseException
 */
	public User add(String user) throws JSONException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject json = new JSONObject(user);
		if (user == null) {
			return null;
		}
		User user1 = new User();
		Date date=new Date();
		if (json.getString("id").isEmpty()) {
			user1.setId(null);
			if(!AccountValidate(json.getString("account"),json.getString("id"))){
				user1.setUserid("1");
			}else{
				user1.setAccount(json.getString("account"));
				if (json.getString("birthday").equals("")) {
					user1.setBirthday(null);
				} else {
					user1.setBirthday(sdf.parse(json.getString("birthday")));
				}
				if(json.getString("deptid").isEmpty()){
					user1.setDeptid(null);
				}else{
					user1.setDeptid(json.getString("deptid"));
				}
				user1.setEmail(json.getString("email"));
				user1.setHighesteducation(json.getString("highesteducation"));
				user1.setJobnumber(json.getString("jobnumber"));
				user1.setJobtitle(json.getString("jobtitle"));
				user1.setMobile(json.getString("mobile"));
				user1.setNation(json.getString("nation"));
				user1.setNativeplace(json.getString("nativeplace"));
				user1.setPost(json.getString("post"));
				if(json.getString("sex").isEmpty()){
					user1.setSex(null);
				}else{
					user1.setSex(Integer.parseInt(json.getString("sex")));
				}
				user1.setUsername(json.getString("username"));
				user1.setDeleteTag(1);
				userdao.add(user1);
				Account account=new Account();
				account.setId(null);
				account.setAccount(user1.getAccount());
				account.setCreateTime(date);
				account.setDeleteTag(1);
				account.setPassword("123456");
				account.setUpdateTime(date);
				accountDao.addByEntity(account);
				}
		return user1;
		} else {
			User user2 = new User(json.getString("id"));
			String oldAccount=user2.getAccount();
			String newAccount=json.getString("account");
			if (user2 != null) {
				boolean b = AccountValidate(json.getString("account"),json.getString("id"));
				if(!b){
					user2.setUserid("1");
				}else{
					user2.setAccount(json.getString("account"));
					if (json.getString("birthday").equals("")) {
						user1.setBirthday(null);
					} else {
						user2.setBirthday(sdf.parse(json.getString("birthday")));
					}
					if(json.getString("deptid").isEmpty()){
						user2.setDeptid(null);
					}else{
					user2.setDeptid(json.getString("deptid"));
					}
					user2.setEmail(json.getString("email"));
					user2.setHighesteducation(json.getString("highesteducation"));
					user2.setJobnumber(json.getString("jobnumber"));
					user2.setJobtitle(json.getString("jobtitle"));
					user2.setMobile(json.getString("mobile"));
					user2.setNation(json.getString("nation"));
					user2.setNativeplace(json.getString("nativeplace"));
					user2.setPost(json.getString("post"));
					if(json.getString("sex").isEmpty()){
					user2.setSex(null);
					}else{
					user2.setSex(Integer.parseInt(json.getString("sex")));
					}
//					user2.setUserid(null);
					user2.setUsername(json.getString("username"));
					user2.setDeleteTag(1);
					userdao.update(user2);
					userdao.updateAccount(newAccount, oldAccount);
				}
			}
			return user2;
		}
	}

	public boolean update(User user) {
		User user1 = new User();
		user1.setAccount(user.getAccount());
		return userdao.update(user1);
	}

	public int delete(String id) {
		return userdao.delete(id);
	}

	public User getById(String id) {
		return userdao.getUserById(id);
	}
	public boolean AccountValidate(String account,String id){
		@SuppressWarnings("rawtypes")
		List list = userdao.getAllAccount(id);
		if(list.contains(account)){
			return false;
		}else{
			return true;
		}
	}
}
