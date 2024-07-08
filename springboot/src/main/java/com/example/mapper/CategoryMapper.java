package com.example.mapper;

import com.example.entity.Category;
import java.util.List;

/**
 * category related data interface
 */
public interface CategoryMapper {

    /**
     * add
     */
    int insert(Category category);

    /**
     * delete
     */
    int deleteById(Integer id);

    /**
     * update
     */
    int updateById(Category category);

    /**
     * search by id
     */
    Category selectById(Integer id);

    /**
     * search all
     */
    List<Category> selectAll(Category category);

}