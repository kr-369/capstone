<template>
  <div class="main-content" style="width: 50%">

    <el-tabs v-model="activeName" @tab-click="clickTab">
      <el-tab-pane label="Personal Information" name="Personal Information">
        <person-page @update:user="updateUser" />
      </el-tab-pane>
      <el-tab-pane label="My Published Posts" name="My Published Posts">
        <div class="card" style="padding: 5px"><el-button type="primary" @click="addPost">Create a new Post</el-button></div>
        <div style="margin-top: 10px">
          <post-list type="user" :show-opt="true" />
        </div>
      </el-tab-pane>

      <el-tab-pane label="My Likes" name="My Likes">

      </el-tab-pane>
      <el-tab-pane label="My Favorites" name="My Favorites">
       

      </el-tab-pane>
      <el-tab-pane label="My Comments" name="My Comments">


      </el-tab-pane>
    </el-tabs>

    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import PersonPage from "@/components/PersonPage";



export default {
  components: {
    Footer,
    PersonPage
  },
  data() {
    const validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('Please confirm your password'))
      } else if (value !== this.user.newPassword) {
        callback(new Error('Passwords do not match'))
      } else {
        callback()
      }
    }
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      dialogVisible: false,

      rules: {
        password: [
          { required: true, message: 'Please enter your original password', trigger: 'blur' },
        ],
        newPassword: [
          { required: true, message: 'Please enter a new password', trigger: 'blur' },
        ],
        confirmPassword: [
          { validator: validatePassword, required: true, trigger: 'blur' },
        ],
      },
      activeName: 'Personal Information',
      likesCurrent: 'Posts',
      collectCurrent: 'Posts',
      commentCurrent: 'Posts',
    }
  },
  created() {

  },
  methods: {
    updateUser() {
      this.$emit('update:user')
    },
    addPost() {
      window.open('/front/newPost')
    },
    clickTab(tab) {
      console.log(tab)
    },
    update() {

      this.$request.put('/user/update', this.user).then(res => {
        if (res.code === '200') {
          this.$message.success('Save successful')
          localStorage.setItem('xm-user', JSON.stringify(this.user))

          this.$emit('update:user')
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleAvatarSuccess(response, file, fileList) {
      this.$set(this.user, 'avatar', response.data)
    },
    updatePassword() {
      this.dialogVisible = true
    },
    save() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request.put('/updatePassword', this.user).then(res => {
            if (res.code === '200') {

              this.$message.success('Password changed successfully')
              this.$router.push('/login')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
/deep/.el-form-item__label {
  font-weight: bold;
}
/deep/.el-upload {
  border-radius: 50%;
}
/deep/.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  border-radius: 50%;
}
/deep/.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
  border-radius: 50%;
}
.avatar {
  width: 120px;
  height: 120px;
  display: block;
  border-radius: 50%;
}
.category-btn {
  width: fit-content;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
}
.active {
  background-color: #2a60c9 !important;
  color: white !important;
}
</style>