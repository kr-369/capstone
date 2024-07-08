<template>
  <div>
    <div class="search">
      <el-input placeholder="Enter title to search" style="width: 200px; margin-right: 10px" v-model="title"></el-input>
      <el-input placeholder="Enter category to search" style="width: 200px; margin-right: 10px" v-model="categoryName"></el-input>
      <el-input placeholder="Enter username to search" style="width: 200px" v-model="userName"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">Search</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">Reset</el-button>
    </div>

    <div class="operation">
      <el-button type="primary" plain @click="handleAdd">Add</el-button>
      <el-button type="danger" plain @click="delBatch">Batch Delete</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" strip @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="id" label="ID" width="70" align="center" sortable></el-table-column>
        <el-table-column prop="title" label="Title" show-overflow-tooltip></el-table-column>
        <el-table-column prop="descr" label="Description" show-overflow-tooltip></el-table-column>
        <el-table-column prop="cover" label="Cover">
          <template v-slot="scope">
            <div style="display: flex; align-items: center">
              <el-image style="width: 50px; height: 50px; border-radius: 5px" v-if="scope.row.cover"
                        :src="scope.row.cover" :preview-src-list="[scope.row.cover]"></el-image>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="categoryName" label="Category"></el-table-column>
        <el-table-column prop="tags" label="Tags">
          <template v-slot="scope">
            <el-tag v-for="item in JSON.parse(scope.row.tags || '[]')" :key="item" style="margin-right: 5px">{{ item }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="Publisher"></el-table-column>
        <el-table-column prop="date" label="Publish Date"></el-table-column>
        <el-table-column prop="readCount" label="Views"></el-table-column>
        <el-table-column label="View Content">
          <template v-slot="scope">
            <el-button @click="preview(scope.row.content)">View Content</el-button>
          </template>
        </el-table-column>
        <el-table-column label="Operation" align="center" width="180">
          <template v-slot="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">Edit</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
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


    <el-dialog title="Information" :visible.sync="fromVisible" width="60%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item label="Title" prop="title">
          <el-input v-model="form.title" placeholder="Title"></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="descr">
          <el-input type="textarea" v-model="form.descr" placeholder="Description"></el-input>
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
            <el-option value="Backend"></el-option>
            <el-option value="Java"></el-option>
            <el-option value="Interview"></el-option>
            <el-option value="Vue"></el-option>
            <el-option value="Frontend"></el-option>
            <el-option value="Big Data"></el-option>
            <el-option value="Algorithm"></el-option>
            <el-option value="Programmer"></el-option>
            <el-option value="Beginner"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Content" prop="content">
          <div id="editor"></div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">Cancel</el-button>
        <el-button type="primary" @click="save">Save</el-button>
      </div>
    </el-dialog>

    <el-dialog title="Article Content" :visible.sync="fromVisible1" width="50%" :close-on-click-modal="false" destroy-on-close>
      <div class="w-e-text">
        <div v-html="content"></div>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible1 = false">Close</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>
import E from "wangeditor"
import hljs from 'highlight.js'

export default {
  name: "Post",
  data() {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      title: null,
      categoryName: null,
      userName: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {},
      ids: [],
      categoryList: [],
      tagsArr: [],
      editor: null,
      content: '',
      fromVisible1: false
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    preview(content) {
      this.content = content
      this.fromVisible1 = true
    },
    handleAdd() {
      this.form = {}
      this.tagsArr = []
      this.setRichText()
      this.fromVisible = true
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.tagsArr = JSON.parse(this.form.tags || '[]')
      this.fromVisible = true
      this.setRichText()
      setTimeout(() => {
        this.editor.txt.html(this.form.content)
      }, 0)
    },
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
              this.load(1)
              this.fromVisible = false
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    del(id) {
      this.$confirm('Are you sure you want to delete it？', 'Confirm deletion', {type: "warning"}).then(response => {
        this.$request.delete('/post/delete/' + id).then(res => {
          if (res.code === '200') {
            this.$message.success('Operation successful')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
      })
    },
    handleSelectionChange(rows) {
      this.ids = rows.map(v => v.id)   //  [1,2]
    },
    delBatch() {
      if (!this.ids.length) {
        this.$message.warning('Please select data')
        return
      }
      this.$confirm('Are you sure you want to delete these data in batch？', 'Confirm deletion', {type: "warning"}).then(response => {
        this.$request.delete('/post/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {
            this.$message.success('Operation successful')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
      })
    },
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/post/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
          categoryName: this.categoryName,
          userName: this.userName,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })

      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || []
      })
    },
    reset() {
      this.title = null
      this.categoryName = null
      this.userName = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
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
        this.editor.create()
      })
    },
  }
}
</script>

<style scoped>

</style>
