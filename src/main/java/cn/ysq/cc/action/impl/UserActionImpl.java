package cn.ysq.cc.action.impl;

import cn.ysq.cc.action.BaseAction;
import cn.ysq.cc.model.User;
import cn.ysq.cc.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;

@Controller
@RequestMapping("/user/*.do")
public class UserActionImpl implements BaseAction {
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

	@RequestMapping(value = "/user/add.do")
	public String addUser(
			@RequestParam("name") String name,
			@RequestParam("password") String password,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "telephone", required = false) String telephone,
			Model model
			) {
		User user = new User();
		user.setName(name);
		user.setPassword(password);
		user.setEmail(email);
		if (null != telephone)
			user.setTelephone(telephone);
		userService.registeUser(user);

		model.addAttribute("name", name);
		return "redirect:/user/get.do";
	}
}
