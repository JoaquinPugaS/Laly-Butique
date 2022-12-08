<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" ><router-link to="/Products"><img width = "250" height = "60" src="../assets/logo2.png" alt="logo"></router-link></a>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li>
          <a class="nav-link" id="nava" > <router-link to="/Products">Productos</router-link> </a>
        </li>
        <li>
          
          <a class="nav-link" id="nava" > <router-link to="/Cart">Carrito <span style="background-color:purple;font-weight: bold;">{{cartItemsTotal}}</span></router-link> </a>
        </li>
      </ul>
      <a v-if="token == false" class="nav-link"  id="nava"><router-link to='/Login'><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
      </svg></router-link></a>      
      <div v-else class="dropdown">
        <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
      </svg>
        </a>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
          <li><a> <router-link to="/Purchases">Compras</router-link> </a></li>
          <li><a v-on:click="CerrarSesion();">Salir</a></li>
        </ul>
      </div>

    </div>
  </nav>
  <router-view/>
</template>
<script>


export default {
    data(){
        return{
            token: false,
        }
    },
  beforeMount(){
    if(!localStorage.getItem('user_token') && !localStorage.getItem('user_rut')){
      this.token = false
    }else{
      this.token = true
    }
  },
  methods: {
    CerrarSesion(){
      localStorage.removeItem('user_token');
      localStorage.removeItem('user_rut');
      window.location.href='/Products'
    },
  },
  computed:{
    cartItemsTotal(){
      return this.$store.getters.cartItemsTotal
    }
  }
}
</script>
  <style>
  #app {
    font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
  }
  
  nav {
    padding: 30px;
  }
  
  nav a {
    font-weight: bold;
    color: #000000;
  }
  nav a:hover {
    font-weight: bold;
    color: #be7af0;
    text-decoration: none;
  }
  
  nav a.router-link-exact-active {
    color: rgb(192, 145, 244);
  }
  
  input[type=button], input[type=submit], input[type=reset]  {
        background-color: #be7af0;
        border: none;
        color: white;
        padding: 15px 80px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        text-transform: uppercase;
        font-size: 13px;
        -webkit-box-shadow: 0 10px 30px 0 rgba(173, 95, 233, 0.274);
        box-shadow: 0 10px 30px 0 rgba(122, 5, 255, 0.4);
        -webkit-border-radius: 5px 5px 5px 5px;
        border-radius: 5px 5px 5px 5px;
        margin: 5px 20px 40px 20px;
        -webkit-transition: all 0.3s ease-in-out;
        -moz-transition: all 0.3s ease-in-out;
        -ms-transition: all 0.3s ease-in-out;
        -o-transition: all 0.3s ease-in-out;
        transition: all 0.3s ease-in-out;
      }
      
      input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover  {
        /* background-color: #d396fb; */
        background-color: #6b00f7;
      }
      
      input[type=button]:active, input[type=submit]:active, input[type=reset]:active  {
        -moz-transform: scale(0.95);
        -webkit-transform: scale(0.95);
        -o-transform: scale(0.95);
        -ms-transform: scale(0.95);
        transform: scale(0.95);
      }
  </style>
  