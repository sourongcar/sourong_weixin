package com.sourong.menu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sourong.menu.dao.WxmenuVOMapper;
import com.sourong.menu.domain.WxmenuVO;

@Service
public class WxmenuServiceImp implements WxmenuService {
	@Autowired
	private WxmenuVOMapper mapper;

	@Override
	public String get() {
		return mapper.selectByPrimaryKey(1).getJson();
	}

	@Override
	public int Save(String json) {
		WxmenuVO menu = new WxmenuVO();
		menu.setId(1);
		menu.setJson(json);
		return mapper.updateByPrimaryKeySelective(menu);
	}

}
