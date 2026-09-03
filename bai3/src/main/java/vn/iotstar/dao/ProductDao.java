package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface ProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product findById(int id);
    List<Product> findAll();
    List<Product> findTop10();
    List<Product> findAll(int page, int pageSize);
    int count();
}