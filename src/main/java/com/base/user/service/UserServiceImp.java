package com.base.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.common.util.IDUtil;
import com.lingdu.common.util.MD5Util;
import com.base.user.dao.UserVOMapper;
import com.base.user.domain.UserVO;
import com.base.user.domain.UserVOExample;

@Service
public class UserServiceImp implements UserService {
	@Autowired
	private UserVOMapper mapper;

	@Override
	public void addUser(UserVO user) throws Throwable {
		user.setId(IDUtil.uuid());
		String salt = IDUtil.uuid();
		user.setSalt(salt);
		user.setPassword(MD5Util.md5(user.getPassword() + salt));
		mapper.insertSelective(user);
	}

	@Override
	public void deleteUser(String id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public void updateUser(UserVO user) {
		mapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public UserVO getUserByAccount(String account) {
		UserVOExample example = new UserVOExample();
		example.createCriteria().andAccountEqualTo(account);
		List<UserVO> list = mapper.selectByExample(example);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public UserVO getUserById(String id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public UserVO checkLogin(String account, String pwd) throws Throwable {
		UserVO user = this.getUserByAccount(account);
		System.out.println(user);
		if (user != null) {
			String inputPwd = MD5Util.md5(pwd + user.getSalt());
			System.out.println(inputPwd);
			if (user.getPassword().equals(inputPwd)) {// 验证通过
				return user;
			}
		}
		return null;

	}

	public int update(String userid, String oldpassword, String newpassword) throws Exception {
		UserVO user = getUserById(userid);
		String pwd = MD5Util.md5(oldpassword + user.getSalt());
		if (pwd.equals(user.getPassword())) {
			user.setPassword(MD5Util.md5(newpassword + user.getSalt()));
			updateUser(user);
			return 1;
		} else {
			return 0;
		}

	}
	
}
