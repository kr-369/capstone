package com.example.mapper;

import com.example.entity.Post;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * post related data interface
 */
public interface PostMapper {

    /**
     * add
     */
    int insert(Post post);

    /**
     * delete
     */
    int deleteById(Integer id);

    /**
     * update
     */
    int updateById(Post post);

    /**
     * search by ID
     */
    Post selectById(Integer id);

    /**
     * seach all
     */
    List<Post> selectAll(Post post);

    @Select("select * from post where user_id = #{userId}")
    List<Post> selectUserPost(Integer userId);

    @Update("update post set read_count = read_count + 1 where id = #{postId}")
    void updateReadCount(Integer postId);


}