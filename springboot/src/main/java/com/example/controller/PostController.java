package com.example.controller;

import com.example.common.Result;
import com.example.entity.Post;
import com.example.service.PostService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

/**
 * post front-end interface
 **/
@RestController
@RequestMapping("/post")
public class PostController {

    @Resource
    private PostService postService;

    /**
     * add
     */
    @PostMapping("/add")
    public Result add(@RequestBody Post post) {
        postService.add(post);
        return Result.success();
    }

    /**
     * delete
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        postService.deleteById(id);
        return Result.success();
    }

    /**
     * batch delete
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        postService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * update
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Post post) {
        postService.updateById(post);
        return Result.success();
    }

    /**
     * search by ID
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Post post = postService.selectById(id);
        return Result.success(post);
    }

    /**
     * Search all
     */
    @GetMapping("/selectAll")
    public Result selectAll(Post post) {
        List<Post> list = postService.selectAll(post);
        return Result.success(list);
    }


    /**
     * search by page in the postlist
     */
    @GetMapping("/selectPage")
    public Result selectPage(Post post,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Post> page = postService.selectPage(post, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * search from postlist
     */
    @GetMapping("/selectUser")
    public Result selectUser(Post post,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Post> page = postService.selectUser(post, pageNum, pageSize);
        return Result.success(page);
    }

}