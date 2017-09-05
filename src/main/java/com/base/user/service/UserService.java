package com.base.user.service;

import com.base.user.domain.UserVO;

public interface UserService {
	public void addUser(UserVO user) throws Throwable;

	public void deleteUser(String id) throws Throwable;

	public void updateUser(UserVO user) throws Throwable;

	public UserVO getUserByAccount(String account) throws Throwable;

	public UserVO getUserById(String id) throws Throwable;

	public UserVO checkLogin(String account, String pwd) throws Throwable;

	public int update(String userid, String oldpassword, String newpassword) throws Exception;
}
