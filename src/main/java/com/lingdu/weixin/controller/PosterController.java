package com.lingdu.weixin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lingdu.common.util.ConfigUtil;
import com.lingdu.weixin.api.QRTicket;
import com.lingdu.weixin.api.QRTicketRequest;
import com.lingdu.weixin.api.WeixinApi;
import com.sourong.poster.domain.PosterVO;
import com.sourong.poster.service.PosterService;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.service.WxuserService;

@Controller
@RequestMapping("/weixin/poster")
public class PosterController {
	@Autowired
	private WxuserService service;
	@Autowired
	private PosterService posterService;
	
	@RequestMapping("/create")
	public String CreatePoster(String code,ModelMap map) throws Exception{
		if(code==null){
			return "redirect:http://www.sourongdaojia.net";
		}
		String openid=WeixinApi.getOpenid(code);
		if(openid==null){
			return "redirect:http://www.sourongdaojia.net";
		}
		WxuserVO user=service.get(openid);
		if(user!=null&&user.getRole()==2){
			//to get qr code
			QRTicketRequest qrTicReq = new QRTicketRequest();
			qrTicReq.addSceneId(user.getOpenid());
			QRTicket qrTic = WeixinApi.getQrTicket(qrTicReq);
			//获取二维码、头像、模板
			map.addAttribute("qrimg", String.format(ConfigUtil.get("qrshow"), qrTic.getTicket()));
			map.addAttribute("headimg", user.getUserphoto());
			PosterVO poster=posterService.getRandom();
			map.addAttribute("poster", ConfigUtil.get("saveImage")+poster.getPosterurl());
			return "poster";
		}else
			return "redirect:http://www.sourongdaojia.net";
	}

}
