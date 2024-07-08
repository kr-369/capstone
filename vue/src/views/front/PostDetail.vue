<template>
  <div class="main-content">
    <div style="display: flex; grid-gap: 10px">

      <div style="flex: 1; width: 0">
        <div class="card" style="padding: 30px; margin-bottom: 10px">
          <div style="font-weight: bold; font-size: 24px; margin-bottom: 20px">{{ post.title }}</div>
          <div style="color: #666; margin-bottom: 20px">
            <span style="margin-right: 20px"><i class="el-icon-user"></i> {{ post.userName }}</span>
            <span style="margin-right: 20px"><i class="el-icon-date"></i> {{ post.date }}</span>
            <span style="margin-right: 20px"><i class="el-icon-eye"></i> {{ post.readCount }}</span>
            <span>
              <el-tag v-for="item in tagsArr" :key="item" type="primary" style="margin-right:5px">{{ item }}</el-tag>
            </span>
          </div>

          <div class="w-e-text">
            <div v-html="post.content"></div>
          </div>

        </div>

        <!--     Like and collection data  -->
        <div class="card" style="text-align: center; font-size: 20px; color: #666; margin-bottom: 10px">
          <span style="margin-right: 20px; cursor: pointer;" @click="setLikes" :class="{ 'active' : post.userLike }"><i class="el-icon-like"></i> {{ post.likesCount }}</span>
          <span style=" cursor: pointer"  @click="setCollect" :class="{ 'active' : post.userCollect }"><i class="el-icon-star-off"></i> {{ post.collectCount }}</span>
        </div>

<!--        评论-->
        <Comment :fid="postId" module='Post' />
      </div>

      <div style="width: 260px">
        <div class="card" style="margin-bottom: 10px">
          <div style="display: flex; align-items: center; grid-gap: 10px; margin-bottom: 10px">
            <img :src="post.user?.avatar" alt="" style="width: 50px; height: 50px; border-radius: 50%">
            <div style="flex: 1;">
              <div style="font-weight: bold; margin-bottom: 5px">{{ post.user?.name }}</div>
              <div style="color: #666; font-size: 13px" class="line2">{{ post.user?.info }}</div>
            </div>
          </div>

          <div style="display: flex">
            <div style="flex: 1; text-align: center">
              <div style="margin-bottom: 5px">Articles</div>
              <div style="color: #888">{{ post.user?.postCount }}</div>
            </div>
            <div style="flex: 1; text-align: center">
              <div style="margin-bottom: 5px">Likes</div>
              <div style="color: #888">{{ post.user?.likesCount }}</div>
            </div>
            <div style="flex: 1; text-align: center">
              <div style="margin-bottom: 5px">Collect</div>
              <div style="color: #888">{{ post.user?.collectCount }}</div>
            </div>
          </div>
        </div>

        <div class="card" style="margin-bottom: 10px">
          <div style="font-weight: bold; font-size: 20px; padding-bottom: 10px; border-bottom: 1px solid #ddd; margin-bottom: 10px">Related recommendations</div>


        </div>

        <div class="card">
          <div style="display: flex; grid-gap: 10px; ">
            <div style="flex: 1; line-height: 25px">
              Find the right learning circle for you
              Scan to learn high-quality projects
            </div>
            <img src="@/assets/imgs/广告.png" alt="" style="width: 50px; height: 50px; border-radius: 5px">
          </div>
        </div>

      </div>



    </div>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";


export default {
  name: "PostDetail",
  components: {
    Comment,
    Footer
  },
  data() {
    return {
      postId: this.$route.query.postId,
      post: {},
      tagsArr: [],
      recommendList: [],
    }
  },
  created() {
    this.load()

    this.$request.put('/post/updateReadCount/' + this.postId)
  },
  methods: {


  }
}
</script>

<style>
/* blockquote 样式 */
blockquote {
  display: block;
  border-left: 8px solid #d0e5f2;
  padding: 20px 10px;
  margin: 10px 0;
  line-height: 1.4;
  font-size: 100%;
  background-color: #f1f1f1;
}

/* code 样式 */
code {
  display: inline-block;
  *display: inline;
  *zoom: 1;
  background-color: #f1f1f1;
  border-radius: 3px;
  padding: 3px 5px;
  margin: 0 3px;
}
pre code {
  display: block;
}
p {
  line-height: 30px
}

.active {
  color: orange !important;
}
.recommend-title {
  margin-bottom: 5px;
}
.recommend-title:hover {
  color: #2a60c9;
}
.comment-active {
  color: #2a60c9;
}
pre {
  white-space: pre-wrap; /*css-3*/
  white-space: -moz-pre-wrap; /*Mozilla,since1999*/
  white-space: pre-wrap; /*Opera4-6*/
  white-space: -o-pre-wrap; /*Opera7*/
  word-wrap: break-word; /*InternetExplorer5.5+*/
}
</style>