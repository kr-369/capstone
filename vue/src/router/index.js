import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

const routes = [
  {
    path: '/',
    name: 'Manager',
    component: () => import('../views/Manager.vue'),
    redirect: '/home',
    children: [
      { path: '403', name: 'NoAuth', meta: { name: 'No Permission' }, component: () => import('../views/manager/403') },
      { path: 'home', name: 'Home', meta: { name: 'Home Page' }, component: () => import('../views/manager/Home') },
      { path: 'admin', name: 'Admin', meta: { name: 'Admin Info' }, component: () => import('../views/manager/Admin') },
      { path: 'adminPerson', name: 'AdminPerson', meta: { name: 'Personal Info' }, component: () => import('../views/manager/AdminPerson') },
      { path: 'password', name: 'Password', meta: { name: 'Change Password' }, component: () => import('../views/manager/Password') },
      { path: 'user', name: 'User', meta: { name: 'User Info' }, component: () => import('../views/manager/User') },
      { path: 'category', name: 'Category', meta: { name: 'Post Category' }, component: () => import('../views/manager/Category') },
      { path: 'post', name: 'Post', meta: { name: 'Post Info' }, component: () => import('../views/manager/Post') },
    ]
  },
  {
    path: '/front',
    name: 'Front',
    component: () => import('../views/Front.vue'),
    children: [
      { path: 'home', name: 'FHome', meta: { name: 'Home Page' }, component: () => import('../views/front/Home') },
      { path: 'person', name: 'Person', meta: { name: 'Personal Info' }, component: () => import('../views/front/Person') },
      { path: 'postDetail', name: 'PostDetail', meta: { name: 'Post Details' }, component: () => import('../views/front/PostDetail') },
      { path: 'newPost', name: 'NewPost', meta: { name: 'Post Edit' }, component: () => import('../views/front/NewPost') },
    ]
  },
  { path: '/login', name: 'Login', meta: { name: 'Login' }, component: () => import('../views/Login.vue') },
  { path: '/register', name: 'Register', meta: { name: 'Register' }, component: () => import('../views/Register.vue') },
  { path: '*', name: 'NotFound', meta: { name: 'Not Found' }, component: () => import('../views/404.vue') },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// route provent
// router.beforeEach((to ,from, next) => {
//   let user = JSON.parse(localStorage.getItem("xm-user") || '{}');
//   if (to.path === '/') {
//     if (user.role) {
//       if (user.role === 'USER') {
//         next('/front/home')
//       } else {
//         next('/home')
//       }
//     } else {
//       next('/login')
//     }
//   } else {
//     next()
//   }
// })

export default router
