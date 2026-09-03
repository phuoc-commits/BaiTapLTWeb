package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface UserDao {
    User login(String username, String password);
    boolean register(User user);
    boolean checkExistUsername(String username);
}