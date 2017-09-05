package com.lingdu.weixin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.base.user.domain.UserVO;
import com.base.user.service.UserService;
import com.lingdu.weixin.api.Menu;
import com.lingdu.weixin.api.MenuResult;
import com.lingdu.weixin.api.Result;
import com.lingdu.weixin.api.WeixinApi;

@RequestMapping("/weixin")
@Controller
public class MenuController {
	public static final String EVENT_KEY_BOOK_SERVICE = "book_service";
	 @Autowired
	 private UserService userService;

	@RequestMapping("authorization")
	public String verify(HttpSession session) throws IOException {
		if (session.getAttribute("admin") == "true") {
			return "redirect:createmenu.action";
		} else {
			return "createmenu";
		}
	}

	@RequestMapping(value = "menu", method = RequestMethod.POST)
	public String menu(ModelMap map, String account, String password, HttpSession session) throws Throwable {
		UserVO user = userService.checkLogin(account, password);
		if (user!=null) {
			session.setAttribute("admin", "true");
			MenuResult result = WeixinApi.getMenu();
			if (result.getErrcode() == null && result.getErrmsg() == null) {
				Menu root = result.getMenu();
				map.addAttribute("menu", root);
				return "menu";
			} else {
				System.out.println(result.getErrcode() + "：" + result.getErrmsg());
				throw new IOException("获取菜单失败");
			}
		} else {
			return "redirect:authrization.action";
		}
	}

	@RequestMapping(value = "createmenu", method = RequestMethod.GET)
	public String showMenu(ModelMap map, HttpSession session) throws IOException {
		if (session.getAttribute("admin") == "true") {

			/*
			 * Menu root = new Menu(); Button b0 = new Button();
			 * b0.setName("进入官网");
			 * b0.setType(Button.TYPE_VIEW);b0.setSub_button(null);
			 * b0.setUrl("http://www.sourongdaojia.net/sourongcar/"); Button b1
			 * = new Button(); b1.setName("服务"); Button b11 = new Button();
			 * b11.setName("生成海报"); b11.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/poster/create.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b11.setType(Button.TYPE_VIEW); Button b12 = new Button();
			 * b12.setName("成为合伙人"); b12.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/partners.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b12.setType(Button.TYPE_VIEW); Button b13 = new Button();
			 * b13.setName("服务预约"); b13.setKey(EVENT_KEY_BOOK_SERVICE);
			 * b13.setType(Button.TYPE_CLICK); Button b2 = new Button();
			 * b2.setName("我的"); Button b21 = new Button(); b21.setName("个人信息");
			 * b21.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/info.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b21.setType(Button.TYPE_VIEW); Button b22 = new Button();
			 * b22.setName("我的下家"); b22.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/trees.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b22.setType(Button.TYPE_VIEW); b1.addSubButton(b11);
			 * b1.addSubButton(b12); b1.addSubButton(b13); b2.addSubButton(b21);
			 * b2.addSubButton(b22); root.addButton(b0); root.addButton(b1);
			 * root.addButton(b2);
			 */
			// Menu root=JSON.parseObject(service.get(), Menu.class);
			MenuResult result = WeixinApi.getMenu();
			if (result.getErrcode() == null && result.getErrmsg() == null) {
				Menu root = result.getMenu();
				map.addAttribute("menu", root);
				return "menu";
			} else {
				throw new IOException("获取菜单失败");
			}
		} else {
			return "redirect:authrization.action";
		}
	}

	@RequestMapping(value = "createmenu", method = RequestMethod.POST)
	public @ResponseBody String create(String menu, HttpServletRequest req) throws IOException {
		HttpSession session = req.getSession();
		if (session.getAttribute("admin") != null) {
			/*
			 * Menu root = new Menu(); Button b0 = new Button();
			 * b0.setName("进入官网"); b0.setType(Button.TYPE_VIEW);
			 * b0.setUrl("http://www.sourongdaojia.net/sourongcar/"); Button b1
			 * = new Button(); b1.setName("服务"); Button b11 = new Button();
			 * b11.setName("生成海报"); b11.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/poster/create.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b11.setType(Button.TYPE_VIEW); Button b12 = new Button();
			 * b12.setName("成为合伙人"); b12.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/partners.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b12.setType(Button.TYPE_VIEW); Button b13 = new Button();
			 * b13.setName("服务预约"); b13.setKey(EVENT_KEY_BOOK_SERVICE);
			 * b13.setType(Button.TYPE_CLICK); Button b2 = new Button();
			 * b2.setName("我的"); Button b21 = new Button(); b21.setName("个人信息");
			 * b21.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/info.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b21.setType(Button.TYPE_VIEW); Button b22 = new Button();
			 * b22.setName("我的下家"); b22.setUrl(
			 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
			 * ConfigUtil.get("appID") +
			 * "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/trees.action&response_type=code&scope=snsapi_base#wechat_redirect"
			 * ); b22.setType(Button.TYPE_VIEW); b1.addSubButton(b11);
			 * b1.addSubButton(b12); b1.addSubButton(b13); b2.addSubButton(b21);
			 * b2.addSubButton(b22); root.addButton(b0); root.addButton(b1);
			 * root.addButton(b2);
			 */
			System.out.println(menu);
			Menu root = JSON.parseObject(menu, Menu.class);//
			// ObjectMapper mp=new ObjectMapper();
			// mp.setSerializationInclusion(Include.NON_NULL);
			// Menu root=mp.readValue(menu, Menu.class);//
			// for(Button b : root.getButton()){
			// if(b.getSub_button().size()==0){
			// System.out.println("empty subbutton arr");
			// b.setSub_button(null);
			// }
			// else{
			// for(Button sb : b.getSub_button()){
			// sb.setSub_button(null);
			// }
			// }
			// }
			// System.out.println(JSON.toJSONString(root));
			// String json=JSON.toJSONString(root);
			// String json=mp.writeValueAsString(root);
			// System.out.println(json);
			// if(1==service.Save(json))
			// return "success";
			// else
			// return "fail";
			Result result = WeixinApi.createMenu(root);
			if (result.getErrcode() == 0 && result.getErrmsg().equals("ok"))
				return "success";
			else {
				return "fail";
			}

		} else {
			System.out.println("please login");
			return "fail";
		}
	}
}
