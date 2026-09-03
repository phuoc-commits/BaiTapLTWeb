package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Product;

public interface ProductService {
    void insert(Product product);
    void edit(Product product);
    void delete(int id);
    Product get(int id);
    List<Product> getAll();
}