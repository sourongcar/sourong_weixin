package com.lingdu.weixin.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lingdu.common.util.ConfigUtil;
import com.lingdu.weixin.api.Button;
import com.lingdu.weixin.api.Menu;
import com.lingdu.weixin.api.Result;
import com.lingdu.weixin.api.WeixinApi;

@RequestMapping("/weixin")
@Controller
public class MenuController {
	public static final String EVENT_KEY_BOOK_SERVICE = "book_service";

	@RequestMapping("authrization")
	public String verify() throws IOException {
		return "createmenu";
	}

	@RequestMapping("createmenu")
	public @ResponseBody String create(String account, String password) throws IOException {
		if (account.equals("admin") && password.equals("123")) {
			Menu root = new Menu();
			Button b0 = new Button();
			b0.setName("进入官网");
			b0.setType(Button.TYPE_VIEW);
			b0.setUrl("http://www.sourongdaojia.net/sourongcar/");
			Button b1 = new Button();
			b1.setName("服务");
			Button b11 = new Button();
			b11.setName("生成海报");
			b11.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + ConfigUtil.get("appID")
					+ "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/poster/create.action&response_type=code&scope=snsapi_base#wechat_redirect");
			b11.setType(Button.TYPE_VIEW);
			Button b12 = new Button();
			b12.setName("成为合伙人");
			b12.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + ConfigUtil.get("appID")
					+ "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/partners.action&response_type=code&scope=snsapi_base#wechat_redirect");
			b12.setType(Button.TYPE_VIEW);
			Button b13 = new Button();
			b13.setName("服务预约");
			b13.setKey(EVENT_KEY_BOOK_SERVICE);
			b13.setType(Button.TYPE_CLICK);
			Button b2 = new Button();
			b2.setName("我的");
			Button b21 = new Button();
			b21.setName("个人信息");
			b21.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + ConfigUtil.get("appID")
					+ "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/info.action&response_type=code&scope=snsapi_base#wechat_redirect");
			b21.setType(Button.TYPE_VIEW);
			Button b22 = new Button();
			b22.setName("我的下家");
			b22.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + ConfigUtil.get("appID")
					+ "&redirect_uri=http://www.sourongdaojia.net/sourongcar/weixin/trees.action&response_type=code&scope=snsapi_base#wechat_redirect");
			b22.setType(Button.TYPE_VIEW);
			b1.addSubButton(b11);
			b1.addSubButton(b12);
			b1.addSubButton(b13);
			b2.addSubButton(b21);
			b2.addSubButton(b22);
			root.addButton(b0);
			root.addButton(b1);
			root.addButton(b2);
			Result result = WeixinApi.createMenu(root);
			if (result.getErrcode() == 0 && result.getErrmsg().equals("ok"))
				return "success";
			else {
				return "fail";
			}
		} else
			return "fail";
	}
}
