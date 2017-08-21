package com.lingdu.handler.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lingdu.common.util.MessageUtil;
import com.lingdu.weixin.api.UserInfo;
import com.lingdu.weixin.api.WeixinApi;
import com.lingdu.weixin.message.WeixinMessageUtil;
import com.lingdu.weixin.message.WeixinRequest;
import com.lingdu.weixin.message.WeixinTextResponse;
import com.sourong.wxuser.dao.WxuserVOMapper;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.domain.WxuserVOExample;

@Service
public class SubscribeMessageHandlerServiceImp implements MessageHandlerService {
	@Autowired
	WxuserVOMapper mapper;

	@Override
	public boolean match(WeixinRequest request) throws Throwable {
		return request.getMsgType().equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)
				&& (request.getEvent().equals(MessageUtil.EVENT_TYPE_SUBSCRIBE) || request.getEvent().equals(MessageUtil.EVENT_TYPE_SCAN));
	}

	@Override
	public String processMsg(WeixinRequest request) throws Throwable {
		String openId = request.getFromUserName();
		Integer referrerId = request.getEventKey() == null ? null : Integer.parseInt(request.getEventKey().substring("qrscene_".length()));
		WxuserVOExample example = new WxuserVOExample();
		example.createCriteria().andOpenidEqualTo(openId);
		List<WxuserVO> users = mapper.selectByExample(example);
		WxuserVO user;
		UserInfo userInfo = WeixinApi.getUserInfo(openId);
		if (users != null && users.size() == 1) {// 关注过
			user = users.get(0);
			WxuserVO entity = new WxuserVO();
			entity.setUserid(user.getUserid());
			if (user.getUserphone() == null) {// 未注册，更新上家
				user.setReferrerid(referrerId);
			}
			user.setCreatetime(null);
			user.setChangetime(null);
			entity.setNickname(userInfo.getNickname());
			entity.setUserphoto(userInfo.getHeadimgurl());
			mapper.updateByPrimaryKey(entity);
		} else {// 没关注过
			user = new WxuserVO();
			user.setOpenid(openId);
			user.setReferrerid(referrerId);
			user.setRole(referrerId == null ? 0 : 1);
			user.setNickname(userInfo.getNickname());
			user.setUserphoto(userInfo.getHeadimgurl());
			mapper.insertSelective(user);
		}
		WeixinTextResponse response = new WeixinTextResponse();
		response.setFromUserName(request.getToUserName());
		response.setToUserName(request.getFromUserName());
		response.setContent("欢迎关注搜融好车官方服务号" + (user.getRole() == 2 ? "" : "，现正进行推广奖励活动，请通过服务->成为合伙人了解详情"));
		return WeixinMessageUtil.toWeixinResponseXml(response);
	}

}
