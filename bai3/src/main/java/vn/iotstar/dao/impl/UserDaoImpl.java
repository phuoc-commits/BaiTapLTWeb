package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements UserDao {

    @Override
    public User login(String username, String password) {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            // Chỉ đăng nhập thành công khi status = 1 (Đã kích hoạt OTP)
            String jpql = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password AND u.status = 1";
            TypedQuery<User> query = en.createQuery(jpql, User.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            en.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.username = :username";
            TypedQuery<Long> query = en.createQuery(jpql, Long.class);
            query.setParameter("username", username);
            return query.getSingleResult() > 0;
        } finally {
            en.close();
        }
    }

    @Override
    public boolean register(User user) {
        EntityManager en = JpaConfig.getEntityManager();
        EntityTransaction trans = en.getTransaction();
        try {
            trans.begin();
            en.persist(user);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            en.close();
        }
    }

    public User findByEmail(String email) {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.email = :email";
            TypedQuery<User> query = en.createQuery(jpql, User.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            en.close();
        }
    }

    public void insert(User user) {
        EntityManager en = JpaConfig.getEntityManager();
        EntityTransaction trans = en.getTransaction();
        try {
            trans.begin();
            en.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            en.close();
        }
    }

    public void update(User user) {
        EntityManager en = JpaConfig.getEntityManager();
        EntityTransaction trans = en.getTransaction();
        try {
            trans.begin();
            en.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            en.close();
        }
    }
}