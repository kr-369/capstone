<template>
  <div style="width: 50%; margin: 5px auto">
    <div class="card" style="margin-bottom: 100px">
      <div style="font-weight: bold; font-size: 24px; margin-bottom: 50px">Publish New Post/Edit Post</div>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item label="Title" prop="title">
          <el-input v-model="form.title" placeholder="Title"></el-input>
        </el-form-item>
        <el-form-item label="Description" prop="descr">
          <el-input type="textarea" v-model="form.descr" ></el-input>
        </el-form-item>
        <el-form-item label="Cover" prop="cover">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture"
              :on-success="handleCoverSuccess"
          >
            <el-button type="primary">Upload Cover</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="Category" prop="categoryId">
          <el-select v-model="form.categoryId" style="width: 100%">
            <el-option v-for="item in categoryList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Tags" prop="tags">
          <el-select v-model="tagsArr" multiple filterable allow-create default-first-option style="width: 100%">

          </el-select>
        </el-form-item>
        <el-form-item label="Content" prop="content">
          <div id="editor"></div>
        </el-form-item>
      </el-form>
      <div style="text-align: center"><el-button type="primary" size="medium" style="width: 100px" @click="save">Save</el-button></div>
    </div>
  </div>
</template>

<script>
import E from "wangeditor";
import hljs from "highlight.js";

export default {
  name: "NewPost",
  data() {
    return {
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {},
      tagsArr: [],
      categoryList: [],
      editor: null,
      postId: this.$route.query.postId
    }
  },
  mounted() {
    this.$request.get('/category/selectAll').then(res => {
      this.categoryList = res.data || []
    })

    this.$request.get('/post/selectById/' + this.postId).then(res => {
      this.form = res.data || {}
      if (this.form.id) {
        this.tagsArr = JSON.parse(this.form.tags || '[]')
        setTimeout(() => {
          this.editor.txt.html(this.form.content)
        }, 0)
      }
    })

    this.setRichText()
  },
  methods: {
    save() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.tags = JSON.stringify(this.tagsArr)
          this.form.content = this.editor.txt.html()
          this.$request({
            url: this.form.id ? '/post/update' : '/post/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {
              this.$message.success('Save successful')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    handleCoverSuccess(res) {
      this.form.cover = res.data
    },
    setRichText() {
      this.$nextTick(() => {
        this.editor = new E(`#editor`)
        this.editor.highlight = hljs
        this.editor.config.uploadImgServer = this.$baseUrl + '/files/editor/upload'
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHeaders = {
          token: this.user.token
        }
        this.editor.config.uploadImgParams = {
          type: 'img',
        }
        this.editor.config.zIndex = 0
        this.editor.create()
      })
    },
  }
}
</script>

<style scoped>

</style>