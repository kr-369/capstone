<template>
  <div class="main-content">
    <div style="display: flex; align-items: flex-start; grid-gap: 10px">

      <div style="width: 150px" class="card">
        <div class="category-item" :class="{ 'category-item-active': item.name === current }"
             v-for="item in categoryList" :key="item.id" @click="selectCategory(item.name)">{{ item.name }}</div>
      </div>

      <div style="flex: 1;">

        <post-list :categoryName="current" ref="postListRef" />

        <Footer />

      </div>

      <div style="width: 260px">
        <div class="card" style="margin-bottom: 10px">
          <div style="font-size: 20px; font-weight: bold; margin-bottom: 10px">Welcome！😊</div>
          <a href="/front/person"><div style="color: #666">Write a post to record a beautiful day</div></a>
        </div>

        <div class="card" style="margin-bottom: 10px">
          <div style="display: flex; align-items: center; padding-bottom: 10px; border-bottom: 1px solid #ddd">
            <div style="font-size: 20px; flex: 1">Trending Posts </div>
            <div style="font-size: 12px; color: #666; cursor: pointer;" @click="refreshTop"><i class="el-icon-refresh"></i> Refresh</div>
          </div>
          <div>
            <div v-for="item in showList" :key="item.id" style="margin: 15px 0" class="line1">
              <a :href="'/front/postDetail?postId=' + item.id" target="_blank">
                <span style="width: 18px; display: inline-block; text-align: right; margin-right: 10px">
                  <span style="color: orangered" v-if="item.index === 1">{{ item.index }}</span>
                  <span style="color: goldenrod" v-else-if="item.index === 2">{{ item.index }}</span>
                  <span style="color: dodgerblue" v-else-if="item.index === 3">{{ item.index }}</span>
                  <span style="color: #666" v-else>{{ item.index }}</span>
                </span>
                <span style="color: #666;">{{ item.title }}</span>
              </a>
            </div>
          </div>
        </div>

        <div style="margin-bottom: 10px">
          <div v-for="item in topItemList" :key="item.id" style="margin-bottom: 10px">
            <a :href="'/front/itemDetail?itemId=' + item.id" target="_blank"><img :src="item.cover" alt="" style="width: 100%; border-radius: 5px"></a>
          </div>
        </div>

        <div style="line-height: 30px; color: #666; padding: 0 10px">
          <div>Report Email： feedback@post.io</div>
          <div>Report Phone： 1-604 556 7892</div>
          <div>© 2024 Fairleigh Dickinson University, All Rights Reserved </div>
        </div>

      </div>



    </div>
  </div>
</template>

<script>

import Footer from "@/components/Footer";
export default {
  components: {

    Footer
  },
  data() {
    return {
      current: 'All Posts',
      categoryList: [],

      topList: [],
      showList: [],
      lastIndex: 0,
      topItemList: []
    }
  },
  mounted() {
    this.load()

    this.refreshTop()

    this.loadTopItem()

  },
  methods: {
    loadTopItem() {
      this.$request.get('/item/selectTop').then(res => {
        this.topItemList = res.data || []
      })
    },
    refreshTop() {
      this.$request.get('/post/selectTop').then(res => {
        this.topList = res.data || []
        let i = 1
        this.topList.forEach(item => item.index = i++)

        // 0  5  0
        if (this.lastIndex === 20) {
          this.lastIndex = 0
        }
        this.showList = this.topList.slice(this.lastIndex, this.lastIndex+5)  // 0-5   5- 10  // 0-5
        this.lastIndex += 5  // 5  10  5
      })
    },
    selectCategory(categoryName) {
      this.current = categoryName
    },
    load() {
      // 请求分类的数据
      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || []
        this.categoryList.unshift({ name: 'All Posts' })
      })
    },
  }
}
</script>

<style>
.category-item {
  text-align: center;
  padding: 10px 0;
  font-size: 16px;
  cursor: pointer;
}
.category-item-active {
  background-color: #1890ff;
  color: #fff;
  border-radius: 5px;
}


</style>
