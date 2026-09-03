package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface UserService {
    User login(String username, String password);
    boolean register(String username, String password, String email);
    boolean checkExistUsername(String username);
}