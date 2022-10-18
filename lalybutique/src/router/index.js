import { createRouter, createWebHistory } from 'vue-router'
import HomeAdminView from '../views/AdminView'
import AdminDash from '../views/AdminDash'
import HomeView from '../views/HomeView'
import CreateProduct from '../components/Admin/CreateProduct'
import ListProducts from '../components/Admin/ListProducts'
import EditProduct from '../components/Admin/EditProduct'
import RopaHombre from '../components/RopaHombre'
import RopaMujer from '../components/RopaMujer'
import LoginView from '../components/LoginView'
import HomePeople from '../HomePeople'
import ProductsCatalog from '../components/ProductsCatalog'
import ProductDetail from '../components/ProductDetail'

const routes = [
  {
    path: '/AdminView',
    name: 'homeAdmin',
    component: HomeAdminView
  },
  {
    path: '/AdminDash',
    name: 'Dashboard',
    component: AdminDash
  },
  {
    path: '/CreateProduct',
    name: 'CreateProduct',
    component: CreateProduct
  },
  {
    path: '/Products',
    name: 'Products',
    component: ProductsCatalog
  },
  {
    path: '/EditProduct/:id',
    name: 'EditProduct',
    component: EditProduct
  },
  {
    path: '/Product/:id',
    name: 'ProductDetail',
    component: ProductDetail
  },
  {
    path: '/ListProducts',
    name: 'ListProducts',
    component: ListProducts
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