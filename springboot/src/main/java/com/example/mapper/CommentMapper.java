package com.example.mapper;

import com.example.entity.Comment;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CommentMapper {


    int insert(Comment comment);


    int deleteById(Integer id);


    int updateById(Comment comment);


    Comment selectById(Integer id);


    List<Comment> selectAll(Comment comment);


    List<Comment> selectForUser(Comment comment);

    @Select("select count(*) from comment where fid = #{fid} and module = #{module}")
    Integer selectCount(@Param("fid") Integer fid, @Param("module") String module);

}