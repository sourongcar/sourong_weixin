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

	//更改role信息
		@Override
		public int upde(String openid,int role) {
			WxuserVOExample example =new WxuserVOExample();
			example.createCriteria().andOpenidEqualTo(openid);
			WxuserVO user=new WxuserVO();
			user.setRole(role);
			return mapper.updateByExampleSelective( user,example);
		}
	//查询信息
		@Override
		public List<WxuserVO> select(String openid) {
			WxuserVO up=get(openid);//上家
			WxuserVOExample example= new WxuserVOExample();
			//创建查询条件Referrerid = up.getUserid
			example.createCriteria().andReferreridEqualTo(up.getUserid());
			List<WxuserVO> list= mapper.selectByExample(example);
			for(WxuserVO u:list){
				example.or().andReferreridEqualTo(u.getUserid());
			}
			return mapper.selectByExample(example);
		}

		@Override
		public int updateInfo(WxuserVO user) {
			if(user.getRole().equals(0)){
				user.setRole(1);
			}
			return mapper.updateByPrimaryKey(user);
		}

}
