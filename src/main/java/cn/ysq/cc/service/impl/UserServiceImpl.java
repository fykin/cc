package cn.ysq.cc.service.impl;

import cn.ysq.cc.dao.UserDao;
import cn.ysq.cc.model.User;
import cn.ysq.cc.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource
	UserDao userDao;

	public User getUser(Long id) {
		return userDao.getUserById(id);
	}

	public User getUser(String name) {
		return userDao.getUserByName(name);
	}
}
