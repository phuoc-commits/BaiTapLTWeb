package vn.iotstar.service.impl;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        return userDao.login(username, password);
    }

    @Override
    public boolean register(String username, String password, String email) {
        if (userDao.checkExistUsername(username)) return false;
        return userDao.register(new User(0, username, password, email, 2)); // 2: Role User mặc định
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }
}