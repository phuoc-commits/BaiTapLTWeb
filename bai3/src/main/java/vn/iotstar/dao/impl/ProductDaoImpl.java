package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements ProductDao {

    @Override
    public void insert(Product product) {
        EntityManager en = JpaConfig.getEntityManager();
        EntityTransaction trans = en.getTransaction();
        try {
            trans.begin();
            en.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            en.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager en = JpaConfig.getEntityManager();
        EntityTransaction trans = en.getTransaction();
        try {
            trans.begin();
            en.merge(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            en.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager en = JpaConfig.getEntityManager();
        EntityTransaction trans = en.getTransaction();
        try {
            trans.begin();
            Product p = en.find(Product.class, id);
            if (p != null) en.remove(p);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            en.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            return en.find(Product.class, id);
        } finally {
            en.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = en.createNamedQuery("Product.findAll", Product.class);
            return query.getResultList();
        } finally {
            en.close();
        }
    }

    @Override
    public List<Product> findTop10() {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = en.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            en.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = en.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            en.close();
        }
    }

    @Override
    public int count() {
        EntityManager en = JpaConfig.getEntityManager();
        try {
            TypedQuery<Long> query = en.createQuery("SELECT count(p) FROM Product p", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            en.close();
        }
    }
}