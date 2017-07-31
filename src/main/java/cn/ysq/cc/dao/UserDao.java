package cn.ysq.cc.dao;

import cn.ysq.cc.model.User;
import org.springframework.dao.DataAccessException;


public interface UserDao {

	User getUserById(Long id) throws DataAccessException;
	User getUserByName(String name) throws DataAccessException;

	void updateUser(User user) throws DataAccessException;
	void insertUser(User user) throws DataAccessException;

}
