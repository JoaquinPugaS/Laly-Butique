import { createRouter, createWebHistory } from 'vue-router'
import HomeAdminView from '../views/AdminView'
import Dashboard from '../views/AdminDash'
import UsersView from '../views/UsersView'
import CreateProduct from '../components/Admin/CreateProduct'
import ListProducts from '../components/Admin/ListProducts'
import EditProduct from '../components/Admin/EditProduct'
import RopaHombre from '../components/RopaHombre'
import RopaMujer from '../components/RopaMujer'
import LoginView from '../components/LoginView'
import Cart from '../components/ShoppingCart'
import ProductsCatalog from '../components/ProductsCatalog'
import ProductDetail from '../components/ProductDetail'
import CheckoutCart from '../components/CheckoutCart'
import ConfirmacionPago from '../views/ConfirmacionPago'
const routes = [
  {
    path: '/admin',
    name: 'admin',
    component: HomeAdminView,
    children: [
      {
        path: '/admin/CreateProduct',
        name: 'CreateProduct',
        component: CreateProduct
      },
      {
        path: '/admin/EditProduct/:id',
        name: 'EditProduct',
        component: EditProduct
      },
      {
        path: '/admin/ListProducts',
        name: 'ListProducts',
        component: ListProducts
      },
      {
        path: '/admin/Dashboard',
        name: 'Dashboard',
        component: Dashboard
      },
    ]
  },
  {
    path:'/',
    name:'UsersView',
    component:UsersView,
    children:[
      {
        path: '/Products',
        name: 'Products',
        component: ProductsCatalog
      },
      {
        path: '/Product/:id',
        name: 'ProductDetail',
        component: ProductDetail
      },
      {
        path:'/Login',
        name:'Login',
        component:LoginView
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
        path:'/Cart',
        name: 'Cart',
        component: Cart
      },
      {
        path:'/Checkout',
        name: 'Checkout',
        component: CheckoutCart
      },
      {
        path:'/confirmacion',
        name: 'confirmacion',
        component: ConfirmacionPago
      },
      
      
    ]
  },
  
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router