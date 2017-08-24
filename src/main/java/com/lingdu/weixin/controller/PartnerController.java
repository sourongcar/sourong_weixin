package com.lingdu.weixin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lingdu.weixin.api.WeixinApi;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.service.WxuserService;

@Controller
@RequestMapping("/weixin/")
public class PartnerController {

	@Autowired
	private WxuserService service;

	@RequestMapping("/partners")
	private String partnermager(String code, ModelMap map) throws Exception {
		// 判断微信发过来的code是否为空
		if (code == null) {
			return "redirect:http://www.sourongdaojia.net";
		}
		// 获取openid
		String openid = WeixinApi.getOpenid(code);
		// 判断openid是否为空
		if (openid == null) {
			return "redirect:http://www.sourongdaojia.net";
		}
		// 把openid放进session
		map.addAttribute("openid", openid);
		// 从openid取出role，0跳到完善信息，1跳到成为合伙人页面
		WxuserVO user = service.get(openid);
		// 判断role
		if (user != null && user.getRole() == 0) {
			return "personinfo";
		} else if (user != null && user.getRole() == 1) {
			return "hehuoren";
		} else if (user != null && user.getRole() == 2) {
			return "success";
		} else
			return "redirect:http://www.sourongdaojia.net";
	}

	@RequestMapping("/update")
	private @ResponseBody String upderole(ModelMap map, String openid) {
		// 判断openid是否为空
		if (openid == null) {
			return "redirect:http://www.sourongdaojia.net";
		}
		WxuserVO role = service.get(openid);
		if(role.getRole()==1){
			// 用service 引用方法
			service.upde(openid, 2);
			return "success";
		}
		else{
			return "fail";
		}
	}
}
