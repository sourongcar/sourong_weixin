package com.sourong.wxuser.service;

import com.sourong.wxuser.domain.WxuserVO;

public interface WxuserService {
	WxuserVO get(String openid);
}
