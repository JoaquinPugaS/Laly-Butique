<template>
  
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#"><img width = "250" height = "60" src="./assets/logo2.png" alt="logo"></a>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li>
          <a class="nav-link" href="#"><router-link to="/">Resumen</router-link> </a>
        </li>
        <li>
          <a class="nav-link" href="#"><router-link to="/create">Crear</router-link> </a>
          
        </li>
        <li>
          <a class="nav-link" href="#"> <router-link to="/read">Productos</router-link> </a>
          
          
        </li>
        <!-- <li>
          <a class="nav-link" href="http://localhost/test/">test base de datos</a> 
          
        </li> -->
        
        
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Buscar" aria-label="Search">
        <button class="btn btn-outline my-2 my-sm-0" type="submit" style="background-color:white; border-color:purple;color:purple">Buscar</button>
      </form>
      <a class="nav-link" ><router-link to='/LoginView'><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
      </svg></router-link></a>
    </div>
  </nav>
  <router-view/>
</template>
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
</style>
