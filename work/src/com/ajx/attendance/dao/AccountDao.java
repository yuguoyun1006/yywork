package com.ajx.attendance.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ajx.attendance.pojo.Account;
import com.ajx.attendance.utils.BaseDao;

@Repository
public class AccountDao extends BaseDao{
	public List<Account> list(String account){
		String hql="";
		List<Account> list;
		if(account==null || account == ""){
			hql = "from Account where deleteTag=1";
			 list=queryListTableByHql(hql,null);
		}else{
			hql = "from Account where account like ? and deleteTag=1";
			list = queryListTableByHql(hql,new String[]{"%"+account+"%"});
		}
		return list;
	}
	
	public List<Map<String,Object>>list1(String id,String account){
		String hql="";
		List<Map<String,Object>> list;
		if((id==null||id.isEmpty())&&(account==null||account.isEmpty())){
			hql="select * from user_account where delete_tag = 1";
			list=getListBySql(hql,null);
		}else if((account == null || account=="")&&!(id==null||id.isEmpty())){
			hql="select * from user_account where FIND_IN_SET(dept_id,getChildLst(?)) and delete_tag = 1";
//			hql="select * from user_account where delete_tag = 1 and dept_id=?";
			list=getListBySql(hql,new String []{id});
		}else if (!(account == null || account=="")&&(id==null||id.isEmpty())){
			hql="select * from user_account where FIND_IN_SET(dept_id,getChildLst(1)) and account like ? and delete_tag = 1";
//			hql="select * from user_account where account like ? and delete_tag = 1";
			list = getListBySql(hql,new String[]{"%"+account+"%"});
		}else{
			hql="select * from user_account where FIND_IN_SET(dept_id,getChildLst(?)) and account like ? and delete_tag = 1";
			list = getListBySql(hql,new String[]{id,"%"+account+"%"});
		}
		return list;
	}
	/**
	 * 逻辑删除
	 * @param id
	 * @return
	 */
	public int delete(String id){
		String sql = "update account set delete_tag = 0 where id ="+"'"+id+"'";
		int i=updateBySql(sql,null);
    	return i;
	}

	//删除
	public boolean del(String id){
		boolean b = false;
		if(deleteById(Account.class,id)){
			b = true;
			return b;
		}
			return b;
	}
	//根据id查询账户
	public Account getAccountById(String id){
		return (Account) getEntityById(Account.class,id);
	}
	
	//修改 
	public boolean updateaccount(Account account){
		return updateByEntity(account);
	}
	//根据id重置账户密码
	public int updatepassword(String id){
		String sql="update account set password='123456' where id=?";
		return updateBySql(sql,new String[]{id});
	}
	
	public boolean upadtetime(Account account){
		return updateByEntity(account);
	}
	@SuppressWarnings("rawtypes")
	public List updateaccount(String id){
		List list = null;
		if(id==""||id==null){
			String sql = "select account from account where delete_tag = 1"; 
			list = getListEntityBySql(sql,null);
		}else{
			String sql = "select account from account where delete_tag = 1 and id != ?";
			list = getListEntityBySql(sql,new String []{id});
		}
		return list;
	}

}
