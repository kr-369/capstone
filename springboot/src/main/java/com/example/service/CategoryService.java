package com.example.service;

import com.example.entity.Category;
import com.example.mapper.CategoryMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CategoryService {

    @Resource
    private CategoryMapper categoryMapper;

    /**
     * add
     */
    public void add(Category category) {
        categoryMapper.insert(category);
    }

    /**
     * delete
     */
    public void deleteById(Integer id) {
        categoryMapper.deleteById(id);
    }

    /**
     * delete batch
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            categoryMapper.deleteById(id);
        }
    }

    /**
     * update
     */
    public void updateById(Category category) {
        categoryMapper.updateById(category);
    }

    /**
     * search by id
     */
    public Category selectById(Integer id) {
        return categoryMapper.selectById(id);
    }

    /**
     * search all
     */
    public List<Category> selectAll(Category category) {
        return categoryMapper.selectAll(category);
    }

    /**
     * search by page
     */
    public PageInfo<Category> selectPage(Category category, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Category> list = categoryMapper.selectAll(category);
        return PageInfo.of(list);
    }

}