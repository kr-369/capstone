<template>
  <div>
    <div class="card" style="min-height: 80vh">
      <div class="post-box" v-for="item in tableData" :key="item.id" v-if="total > 0">
        <div style="flex: 1; width: 0">
          <a :href="'/front/postDetail?postId=' + item.id" target="_blank"><div class="post-title">{{ item.title }}</div></a>
          <div class="line1" style="color: #666; margin-bottom: 10px; font-size: 13px">{{ item.descr }}</div>
          <div style="display: flex; align-items: center">
            <div style="flex: 1; font-size: 13px">
              <span style="color: #666; margin-right: 20px"><i class="el-icon-user"></i> {{ item.userName }}</span>
              <span style="color: #666; margin-right: 20px"><i class="el-icon-eye"></i> {{ item.readCount }}</span>
              <span style="color: #666"><i class="el-icon-like"></i> {{ item.likesCount }}</span>

              <span v-if="showOpt" style="margin-left: 40px; color: red; cursor: pointer" @click="del(item.id)"><i class="el-icon-delete"></i>Delete</span>
              <span v-if="showOpt" style="margin-left: 10px; color: #2a60c9; cursor: pointer" @click="editPost(item.id)"><i class="el-icon-edit"></i>Edit</span>
            </div>
            <div style="width: fit-content">
              <el-tag v-for="(item, index) in JSON.parse(item.tags || '[]')" :key="index" type="primary" style="margin-right:5px">{{ item }}</el-tag>
            </div>
          </div>
        </div>
        <div style="width: 150px">
          <img style="width: 100%; height: 80px; border-radius: 5px" :src="item.cover" alt="">
        </div>
      </div>
      <div v-if="total === 0" style="padding: 20px ;text-align: center; font-size: 16px; color: #666">No Data Available</div>
      <div style="margin-top: 10px" v-if="total">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "PostList",
  props: {
    categoryName: null,
    type: null,
    showOpt: false
  },
  data() {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
    }
  },
  watch: {
    categoryName() {
      this.loadPosts(1)
    }
  },
  created() {
    this.loadPosts(1)
  },
  methods: {
    editPost(postId) {
      window.open('/front/newPost?postId=' + postId)
    },
    del(id) {
      this.$confirm('Are you sure you want to delete this?', 'Confirm Deletion', {type: "warning"}).then(response => {
        this.$request.delete('/post/delete/' + id).then(res => {
          if (res.code === '200') {
            this.$message.success('Operation successful')
            this.loadPosts(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
      })
    },
    loadPosts(pageNum) {
      if (pageNum) this.pageNum = pageNum
      let url
      switch (this.type) {
        case 'user': url = '/post/selectUser'; break;
        case 'like': url = '/post/selectLike'; break;
        case 'collect': url = '/post/selectCollect'; break;
        case 'comment': url = '/post/selectComment'; break;
        default: url = '/post/selectPage'
      }
      this.$request.get(url, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          categoryName: this.categoryName === 'All Posts' ? null : this.categoryName,
          title: this.$route.query.title
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    handleCurrentChange(pageNum) {
      this.loadPosts(pageNum)
    },
  }
}
</script>

<style scoped>
.post-box {
  display: flex;
  grid-gap: 15px;
  padding: 10px 0;
  border-bottom: 1px solid #ddd;
}
.post-box:first-child {
  padding-top: 0;
}
.post-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 10px;
  cursor: pointer;
}
.post-title:hover {
  color: #2a60c9;
}
</style>