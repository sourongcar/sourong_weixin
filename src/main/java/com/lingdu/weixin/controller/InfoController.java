package com.lingdu.weixin.controller;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lingdu.weixin.api.WeixinApi;
import com.sourong.wxuser.domain.WxuserVO;
import com.sourong.wxuser.service.WxuserService;

@Controller
@RequestMapping("/weixin")
public class InfoController {

	@Autowired
	private WxuserService service;

	@RequestMapping("/info")
	private String showinfo(String code, ModelMap map) throws Exception {

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
		// 获取role
		WxuserVO user = service.get(openid);
		// 把openid放进session
		map.addAttribute("openid", openid);
		// 判断role,role为0跳到注册页面 ， 1跳至操作“成为合伙人”,2,跳至查看上下家页面
		if (user != null &&user.getRole() >= 0 && user.getRole() <= 2) {
			if (user.getRole() > 0) {
				map.addAttribute("user", user);
			}
			return "personinfo";
		} else{
			return "redirect:http://www.sourongdaojia.net";
		}
	}

	@RequestMapping(value = "/editinfo", method = RequestMethod.POST)
	private @ResponseBody String editInfo(String phone, String name, String openid){
		// 判断openid是否为空
		if (openid == null) {
			System.out.println("openid null");
			return "fail";
		}
		if(!Pattern.matches("^((0\\d{2,3}-\\d{7,8})|(1[3584]\\d{9}))$", phone)||!Pattern.matches("^[\u4E00-\u9FA5]{4,6}$", name)){
			System.out.println("param invalid.phone:"+phone+"name: "+name);
			return "fail";
		}
		WxuserVO user = service.get(openid);
		user.setUserphone(phone);
		user.setUsername(name);
		// 用service 引用方法
		if (1 == service.updateInfo(user)) {
			return "success";
		} else{
			System.out.println("update fail.phone:"+phone+"- name:"+name);
			return "fail";
		}
	}
	
	@RequestMapping(value = "/success")
	private String success(){
		return "success";
	}
}
