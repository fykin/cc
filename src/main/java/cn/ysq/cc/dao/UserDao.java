package cn.ysq.cc.dao;

import cn.ysq.cc.model.User;


public interface UserDao {

	User getUserById(Long id);
	User getUserByName(String name);

}
