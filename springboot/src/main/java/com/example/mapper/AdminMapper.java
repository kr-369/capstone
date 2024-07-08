package com.example.mapper;

import com.example.entity.Admin;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * admin-related data interface
*/
public interface AdminMapper {

    /**
      * add
    */
    int insert(Admin admin);

    /**
      * delete
    */
    int deleteById(Integer id);

    /**
      * update
    */
    int updateById(Admin admin);

    /**
      * search by id
    */
    Admin selectById(Integer id);

    /**
      * search all
    */
    List<Admin> selectAll(Admin admin);

    @Select("select * from admin where username = #{username}")
    Admin selectByUsername(String username);
}