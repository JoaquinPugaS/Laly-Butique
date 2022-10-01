import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

import CreateComponent from '../components/CreateComponent'
import ReadComponent from '../components/ReadComponent'
import EditComponent from '../components/EditComponent'
import LoginView from '../components/LoginView'
// import CloudinaryUpload from '../components/CloudinaryUpload'
const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/create',
    name: 'create',
    component: CreateComponent
  },
  // {
  //   path: '/upload',
  //   name: 'upload',
  //   component: CloudinaryUpload
  // },
  {
    path: '/edit/:id',
    name: 'edit',
    component: EditComponent
  },
  {
    path: '/read',
    name: 'read',
    component: ReadComponent
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    path:'/LoginView',
    name:'Login',
    component:LoginView
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router