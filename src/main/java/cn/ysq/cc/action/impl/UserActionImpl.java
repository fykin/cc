package cn.ysq.cc.action.impl;

import cn.ysq.cc.action.UserAction;
import cn.ysq.cc.model.User;
import cn.ysq.cc.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;

@Controller
@RequestMapping("/user/*.do")
public class UserActionImpl implements UserAction {
	@Resource
	UserService userService;

	@RequestMapping(value = "/user/get.do")
	public String getUser(@RequestParam(value="name", required = false) String name, Model model) {
		User user = userService.getUser(name);
		if (null == user) {
			user = new User();
			user.setName("not found!");
		}
		model.addAttribute("user", user);

		return "/user";
	}
}
