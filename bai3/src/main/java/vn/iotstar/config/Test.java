package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        try {
            trans.begin();
            Category cate = new Category();
            cate.setCategoryname("Điện thoại");
            cate.setImages("iphone.jpg");
            cate.setStatus(1);
            enma.persist(cate);
            trans.commit();
            System.out.println("-> Thêm mới Category thành công qua JPA!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
        } finally {
            enma.close();
        }
    }
}