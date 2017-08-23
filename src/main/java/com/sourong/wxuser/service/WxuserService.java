package com.sourong.wxuser.service;

import java.util.List;

import com.sourong.wxuser.domain.WxuserVO;

public interface WxuserService {
	WxuserVO get(String openid);
	int upde(String openid,int role);
	List<WxuserVO> select(String openid);
	int updateInfo(WxuserVO user);
}
