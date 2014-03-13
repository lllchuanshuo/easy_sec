package com.easykoo.service;

import com.easykoo.mybatis.dao.CategoryMapper;
import com.easykoo.mybatis.dao.ProductMapper;
import com.easykoo.mybatis.model.Category;
import com.easykoo.mybatis.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by easykooc on 14-2-25.
 */
@Service("productService")
public class ProductServiceImpl implements IProductService {
    private ProductMapper productMapper;
    private CategoryMapper categoryMapper;

    public CategoryMapper getCategoryMapper() {
        return categoryMapper;
    }

    @Autowired
    public void setCategoryMapper(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

    public ProductMapper getProductMapper() {
        return productMapper;
    }

    @Autowired
    public void setProductMapper(ProductMapper productMapper) {
        this.productMapper = productMapper;
    }

    @Override
    public int deleteByPrimaryKey(Integer productId) {
        return productMapper.deleteByPrimaryKey(productId);
    }

    @Override
    public int insert(Product record) {
        return productMapper.insert(record);
    }

    @Override
    public int insertSelective(Product record) {
        return productMapper.insertSelective(record);
    }

    @Override
    public Product selectByPrimaryKey(Integer productId) {
        return productMapper.selectByPrimaryKey(productId);
    }

    @Override
    public int updateByPrimaryKeySelective(Product record) {
        return productMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Product record) {
        return productMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Product> findProductWithPage(Product record) {
        return productMapper.findProductWithPage(record);
    }

    @Override
    public List<Category> getAllCategory() {
        return categoryMapper.getAllCategory();
    }

    @Override
    public List<Category> getTopLevelCategory() {
        return categoryMapper.getTopLevelCategory();
    }

    @Override
    public List<Category> getChildrenCategory(String categoryId) {
        return categoryMapper.getChildrenCategory(categoryId);
    }
}