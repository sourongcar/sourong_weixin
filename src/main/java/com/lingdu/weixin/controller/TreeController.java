package com.lingdu.weixin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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
public class TreeController {
	
	@Autowired
	private WxuserService service;
	
	@RequestMapping("trees")
	private String treemager(String code, ModelMap map,HttpSession session) throws Exception{
		
		//判断微信发过来的code是否为空
		if(code==null){
			return "redirect:http://www.sourongdaojia.net";
		}
		//获取openid
		String openid = WeixinApi.getOpenid(code);
		// 判断openid是否为空
		if (openid == null) {
			return "redirect:http://www.sourongdaojia.net";
		}
		//把openid放进session
		session.setAttribute("openid", openid);
		//获取role
		WxuserVO user = service.get(openid);
		map.addAttribute("user", user);
		//判断role,role为0跳到注册页面  ，  1跳至操作“成为合伙人”,2,跳至查看上下家页面
		if(user != null &&user.getRole()==0){
			return "personinfo";
		}else if(user != null &&user.getRole()==1){
			return "hehuoren";
		}else if(user != null &&user.getRole()==2){
			map.addAttribute("partner", service.select(openid));
			return "followers";
		}
			
		return "redirect:http://www.sourongdaojia.net";
	}
	
	//查询所有下级
	@RequestMapping("/select")
	private @ResponseBody List<WxuserVO> select(ModelMap map,HttpSession session){
		
		//从session取出openid
		String openid= (String) session.getAttribute("openid");
		// 判断openid是否为空
		if (openid == null) {
			return null;
		}
		WxuserVO role = service.get(openid);
		List<WxuserVO> list = new ArrayList<WxuserVO>();
		if(role.getRole()==2){
			list = service.select(openid);
		}
		
		return list;
	}
	
}
