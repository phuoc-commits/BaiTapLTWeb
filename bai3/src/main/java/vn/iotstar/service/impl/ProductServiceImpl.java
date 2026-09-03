package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;

public class ProductServiceImpl implements ProductService {
    private ProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) { productDao.insert(product); }
    @Override
    public void edit(Product product) { productDao.update(product); }
    @Override
    public void delete(int id) { productDao.delete(id); }
    @Override
    public Product get(int id) { return productDao.findById(id); }
    @Override
    public List<Product> getAll() { return productDao.findAll(); }
}