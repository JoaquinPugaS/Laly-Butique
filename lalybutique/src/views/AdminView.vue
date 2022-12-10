<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" ><router-link to="/admin/Dashboard"><img width = "250" height = "60" src="../assets/logo2.png" alt="logo"></router-link></a>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li>
          <a class="nav-link" id="nava"><router-link to="/admin/Dashboard">Resumen</router-link> </a>
        </li>
        <li>
          <a class="nav-link" id="nava"><router-link to="/admin/CreateProduct">Crear</router-link> </a>
          
        </li>
        <li>
          <a class="nav-link" id="nava" > <router-link to="/admin/ListProducts">Productos</router-link> </a>
        </li>
        <li>
          <a class="nav-link" id="nava" > <router-link to="/admin/GenerateSale">Generar Venta</router-link> </a>
        </li>
        <li>
          <a class="nav-link" id="nava" > <router-link to="/admin/CreateType">Crear Tipo</router-link> </a>
        </li>

      </ul>
      <a v-on:click="CerrarSesion();">SALIR</a>
    </div>
  </nav>
  <router-view/>
</template>
<script>

export default {
  methods: {
    CerrarSesion(){
      localStorage.removeItem('admin_token');
      window.location.href='/'
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



#nav {
  padding: 30px;
}

#nava {
  font-weight: bold;
  color: #000000;
}

#nava:hover {
  transform:scale(1.2);
  font-weight: bold;
  color: #be7af0;
  text-decoration: none;
  transition: .3s;
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
      /* -webkit-transition: all 0.3s ease-in-out;
      -moz-transition: all 0.3s ease-in-out;
      -ms-transition: all 0.3s ease-in-out;
      -o-transition: all 0.3s ease-in-out;
      transition: all 0.3s ease-in-out; */
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
