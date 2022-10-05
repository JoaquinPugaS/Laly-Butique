import { createRouter, createWebHistory } from 'vue-router'
import HomeAdminView from '../views/AdminView'
import HomeView from '../views/HomeView'
import CreateComponent from '../components/CreateComponent'
import ReadComponent from '../components/ReadComponent'
import EditComponent from '../components/EditComponent'
import RopaHombre from '../components/RopaHombre'
import RopaMujer from '../components/RopaMujer'
import LoginView from '../components/LoginView'
import HomePeople from '../HomePeople'

// import CloudinaryUpload from '../components/CloudinaryUpload'
const routes = [
  {
    path: '/AdminView',
    name: 'homeAdmin',
    component: HomeAdminView
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
    path:'/HomePeople',
    name:'Home',
    component:HomePeople
  },
  {
    path:'/RopaHombre',
    name:'Hombre',
    component:RopaHombre
  },
  {
    path:'/RopaMujer',
    name:'Mujer',
    component:RopaMujer
  },
  {
    path:'/LoginView',
    name:'Login',
    component:LoginView
  },
  {
    path:'/',
    name:'HomeView',
    component:HomeView
  },
  
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router