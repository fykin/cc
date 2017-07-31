package cn.ysq.cc.service;

import cn.ysq.cc.model.User;

public interface UserService {

	User getUser(Long id);
	User getUser(String name);

	void registeUser(User user);
}
