package com.lingdu.handler.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lingdu.common.util.MessageUtil;
import com.lingdu.weixin.message.WeixinRequest;
import com.sourong.wxuser.dao.WxuserVOMapper;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.domain.WxuserVOExample;

@Service
public class UnsubscribeMessageHandlerServiceImp implements MessageHandlerService {
	@Autowired
	WxuserVOMapper mapper;
	
	@Override
	public boolean match(WeixinRequest request) throws Throwable {
		return MessageUtil.REQ_MESSAGE_TYPE_EVENT.equalsIgnoreCase(request.getMsgType())
				&&(MessageUtil.EVENT_TYPE_UNSUBSCRIBE.equalsIgnoreCase(request.getEvent()));
	}

	@Override
	public String processMsg(WeixinRequest request) throws Throwable {
		String openId = request.getFromUserName();
		WxuserVOExample example = new WxuserVOExample();
		example.createCriteria().andOpenidEqualTo(openId);
		List<WxuserVO> users_list = mapper.selectByExample(example);
		if(users_list!=null && users_list.size()==1){
			WxuserVO vo = users_list.get(0);
			System.out.println(vo);
			vo.setIsdisplay(0);
			mapper.updateByPrimaryKey(vo);
		}
		return "";
	}

}
