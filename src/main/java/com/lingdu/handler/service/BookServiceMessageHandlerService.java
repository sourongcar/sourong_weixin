package com.lingdu.handler.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lingdu.common.util.MessageUtil;
import com.lingdu.weixin.controller.MenuController;
import com.lingdu.weixin.message.WeixinMessageUtil;
import com.lingdu.weixin.message.WeixinRequest;
import com.lingdu.weixin.message.WeixinTextResponse;
import com.sourong.reservation.dao.ReservationVOMapper;
import com.sourong.reservation.domain.ReservationVO;
import com.sourong.reservation.domain.ReservationVOExample;
import com.sourong.wxuser.dao.WxuserVOMapper;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.domain.WxuserVOExample;

@Service
public class BookServiceMessageHandlerService implements MessageHandlerService {
	@Autowired
	private WxuserVOMapper mapper;
	@Autowired
	private ReservationVOMapper reservationMapper;

	@Override
	public boolean match(WeixinRequest request) throws Throwable {
		return MessageUtil.REQ_MESSAGE_TYPE_EVENT.equals(request.getMsgType())
				&& MessageUtil.EVENT_TYPE_CLICK.equals(request.getEvent())
				&& MenuController.EVENT_KEY_BOOK_SERVICE.equals(request.getEventKey());
	}

	@Override
	public String processMsg(WeixinRequest request) throws Throwable {
		String openid = request.getFromUserName();
		WxuserVOExample example = new WxuserVOExample();
		example.createCriteria().andOpenidEqualTo(openid);
		List<WxuserVO> users = mapper.selectByExample(example);
		WeixinTextResponse response = new WeixinTextResponse();
		response.setFromUserName(request.getToUserName());
		response.setToUserName(request.getFromUserName());
		if (users != null && users.size() == 1) {
			WxuserVO user = users.get(0);
			if (user.getRole() == 0) {// 游客
				response.setContent("填写信息后方可预约，请到 我的->个人信息 完善个人信息");
			} else if (user.getRole() >= 1) {// 已注册，可预约
				ReservationVOExample resExample = new ReservationVOExample();
				resExample.createCriteria().andUseridEqualTo(user.getUserid()).andDisposalEqualTo(0);
				if (reservationMapper.countByExample(resExample) > 0) {// 有未处理的预约
					response.setContent("您已经预约过服务，将有工作人员联系您，无需再次预约");
				} else {// 没有未处理的预约，插入预约记录
					ReservationVO reservation = new ReservationVO();
					reservation.setDisposal(0);
					reservation.setUserid(user.getUserid());
					reservation.setUsername(user.getUsername());
					reservation.setUserphone(user.getUserphone());
					reservationMapper.insertSelective(reservation);
					response.setContent("预约成功，，将有工作人员联系您，请耐心等待");
				}
			} else {
				return "success";
			}
		} else {
			return "success";
		}
		return WeixinMessageUtil.toWeixinResponseXml(response);
	}

}
