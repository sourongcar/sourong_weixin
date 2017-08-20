package com.sourong.wxuser.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sourong.wxuser.dao.WxuserVOMapper;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.domain.WxuserVOExample;

@Service
public class WxuserServiceImp implements WxuserService {
	@Autowired
	private WxuserVOMapper mapper;

	@Override
	public WxuserVO get(String openid) {
		WxuserVOExample example = new WxuserVOExample();
		example.createCriteria().andOpenidEqualTo(openid);
		List<WxuserVO> list = mapper.selectByExample(example);
		if (list != null && list.size() == 1) {
			return list.get(0);
		} else
			return null;
	}

}
