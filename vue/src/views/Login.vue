<template>
  <div class="container">
    <div style="width: 380px; padding: 50px 30px; background-color: white; border-radius: 5px;">
      <div style="text-align: center; font-size: 24px; margin-bottom: 30px; color: #333">FDU Peer Support Platform </div>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input size="medium" prefix-icon="el-icon-user" placeholder="Enter Username" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input size="medium" prefix-icon="el-icon-lock" placeholder="Enter Password" show-password  v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item prop="role">
          <el-radio-group v-model="form.role">
            <el-radio label="ADMIN">ADMIN</el-radio>
            <el-radio label="USER">USER</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item prop="code">
          <div style="display: flex">
            <el-input style="flex: 1" size="medium" v-model="code"></el-input>
            <Identify :identifyCode="identifyCode" @click.native="refreshCode" />
          </div>
        </el-form-item>
        <el-form-item>
          <el-button size="medium" style="width: 100%; background-color: #2a60c9; border-color: #2a60c9; color: white" @click="login">Login</el-button>
        </el-form-item>
        <div style="display: flex; align-items: center">
          <div style="flex: 1"></div>
          <div style="flex: 1; text-align: right">
            Don't have an account yet? Please <a href="/register">register</a>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
import Identify from "@/components/Identify"; //import identify to login page

export default {
  name: "Login",
  components: {
    Identify
  },
  data() {
    return {
      form: { role: 'ADMIN' },
      rules: {
        username: [
          { required: true, message: 'Please enter your username', trigger: 'blur' },
        ],
        password: [
          { required: true, message: 'Please enter your password', trigger: 'blur' },
        ]
      },
      code: '',
      identifyCode: '',
      identifyCodes: '123456789ABCDEFGHGKMNPQRSTUVWXY',
    }
  },
  mounted() {
    this.refreshCode()
  },
  methods: { //refresh code
    refreshCode() {
      this.identifyCode = ''
      this.makeCode(this.identifyCodes, 4)
    },//create random code
    makeCode(o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode += this.identifyCodes[Math.floor(Math.random() * (this.identifyCodes.length))]
      }
    },
    login() {
      if (!this.code) {
        this.$message.warning('Please enter the verification code')
        this.refreshCode()
        return
      }
      if (this.code.toLowerCase() !== this.identifyCode.toLowerCase()) {
        this.$message.warning('Verification code is incorrect')
        this.refreshCode()
        return
      }
      this.$refs['formRef'].validate((valid) => {
        if (valid) {//successful
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              localStorage.setItem("xm-user", JSON.stringify(res.data))
              this.$message.success('Login successful')
              setTimeout(() => {

                if (res.data.role === 'ADMIN') {
                  location.href = '/home'
                } else {
                  location.href = '/front/home'
                }
              }, 500)//wrong code
            } else {
              this.refreshCode()
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
.container {
  height: 100vh;
  overflow: hidden;
  background-image: url("@/assets/imgs/bg.jpg");
  background-size: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
a {
  color: #2a60c9;
}
</style>