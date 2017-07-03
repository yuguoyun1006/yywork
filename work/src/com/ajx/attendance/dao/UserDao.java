package com.ajx.attendance.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ajx.attendance.pojo.User;
import com.ajx.attendance.utils.BaseDao;


@Repository
public class UserDao extends BaseDao{
	public List<User> list(String name){
		String hql="";
		List<User> list;
		if(name==null||name==""){
		hql = "from User where delete_tag = 1";
		 list = queryListTableByHql(hql, null);
		}else{
		hql = "from User where username like ? and delete_tag = 1";
		list = queryListTableByHql(hql, new String[]{"%"+name+"%"});
		}
		
		return list;
	}
	public List<Map<String,Object>> list1(String id,String name){
		String hql="";
		List<Map<String,Object>> list;
		if(name==null||name==""){
		hql = "select id,userid,username,dept_id,jobnumber,sex,birthday,nation,highesteducation,jobtitle,post,nativeplace,mobile,email,account from User where FIND_IN_SET(dept_id, getChildLst(?)) and delete_tag = 1";
		list = getListBySql(hql, new String[]{id});
		}else{
		hql = "select id,userid,username,dept_id,jobnumber,sex,birthday,nation,highesteducation,jobtitle,post,nativeplace,mobile,email,account from User where FIND_IN_SET(dept_id, getChildLst(?)) and username like ? and delete_tag = 1";
		list = getListBySql(hql, new String[]{id,"%"+name+"%"});
		}
		
		return list;
	}
	public boolean del(String id){
		return deleteById(User.class, id);
		
	}
	
	public List<Map<String,Object>> userTree(String deptId){
		String sql = "select dept_id,account,username from account_user_dept where delete_tag = 1 and dept_id =?";
		List<Map<String,Object>> list = getListBySql(sql,new String []{deptId});
		return list;
	}
	
	public int updateAccount(String newAccount,String oldAccount){
		String sql="update account t set t.account=? where t.account=?";
		return updateBySql(sql, new String[]{newAccount,oldAccount});
	}
	public void add(User user){
		addByEntity(user);
	}
	public boolean update(User user){
		return updateByEntity(user);
	}
	public int delete(String id){
		String sql = "update user set delete_tag = 0 where id ="+"'"+id+"'";
		User user=getUserById(id);
//		Session session = sessionFactory.openSession();
//    	SQLQuery query = session.createSQLQuery(sql);
//    	int i = query.executeUpdate();
		int i=updateBySql(sql,null);
		String sql1="update account t set t.delete_tag= 0 where t.account=?";
		int j=updateBySql(sql1,new String[]{user.getAccount()});
    	return i;
	}
	public User getUserById(String id){
		return (User) getEntityById(User.class,id);
	}
	public int updateByHql(int newdeptid,int deptid){
//		String hql="update YsUser set daptid=? where daptid=?";
		String sql="update user set dept_id=? where dept_id=?";
		return updateBySql(sql,new String[]{String.valueOf(newdeptid),String.valueOf(deptid)});
	}
	//通过账户更新
		public int updateByAccount(String oldAccount,String newAccount){
			String sql ="update user set account=? where account=?";
			return updateBySql(sql,new String[]{newAccount,oldAccount});
		}
	@SuppressWarnings("rawtypes")
	public List getAllAccount(String id){
		List list = null;
		if(id==""||id==null){
		String sql = "select account from user where delete_tag = 1";
		list = getListEntityBySql(sql, null);
		}else{
		String sql = "select account from user where delete_tag = 1 and id != ?";	
		list = getListEntityBySql(sql, new String[]{id});
		}
		return list;
	}
}
