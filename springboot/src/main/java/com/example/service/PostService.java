package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.PostMapper;
import com.example.utils.TokenUtils;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class PostService {

    @Resource
    private PostMapper postMapper;

    @Resource
    UserService userService;



    /**
     * add
     */
    public void add(Post post) {
        post.setDate(DateUtil.today());
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            post.setUserId(currentUser.getId());
        }
        postMapper.insert(post);
    }

    /**
     * delete
     */
    public void deleteById(Integer id) {
        postMapper.deleteById(id);
    }


    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            postMapper.deleteById(id);
        }
    }

    /**
     * update
     */
    public void updateById(Post post) {
        postMapper.updateById(post);
    }

    /**
     * search by id
     */
    public Post selectById(Integer id) {
        Post post = postMapper.selectById(id);
        User user = userService.selectById(post.getUserId());
        List<Post> userPostList = postMapper.selectUserPost(user.getId());
        user.setPostCount(userPostList.size());
        return post;
    }

    /**
     * search all
     */
    public List<Post> selectAll(Post post) {
        return postMapper.selectAll(post);
    }

    /**
     * search by page
     */
    public PageInfo<Post> selectPage(Post post, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Post> list = postMapper.selectAll(post);
        for (Post b : list) {
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.POST.getValue());
            b.setLikesCount(likesCount);
        }
        return PageInfo.of(list);
    }

    public List<Post> selectTop() {
        List<Post> postList = this.selectAll(null);
        postList = postList.stream().sorted((b1, b2) -> b2.getReadCount().compareTo(b1.getReadCount()))
                .limit(20)
                .collect(Collectors.toList());
        return postList;
    }


    public Set<Post> selectRecommend(Integer postId) {
        Post post = this.selectById(postId);
        String tags = post.getTags();
        Set<Post> postSet = new HashSet<>();
        if (ObjectUtil.isNotEmpty(tags)) {
            List<Post> postList = this.selectAll(null);
            JSONArray tagsArr = JSONUtil.parseArray(tags);
            for (Object tag : tagsArr) {
                // select the tag from other posts
                Set<Post> collect = postList.stream().filter(b -> b.getTags().contains(tag.toString()) && !postId.equals(b.getId()))
                        .collect(Collectors.toSet());
                postSet.addAll(collect);
            }
        }
        postSet = postSet.stream().limit(5).collect(Collectors.toSet());
        postSet.forEach(b -> {
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.POST.getValue());
            b.setLikesCount(likesCount);
        });
        return postSet;
    }

    public void updateReadCount(Integer postId) {
        postMapper.updateReadCount(postId);
    }

    public PageInfo<Post> selectUser(Post post, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            post.setUserId(currentUser.getId());
        }
        return this.selectPage(post, pageNum, pageSize);
    }


}
