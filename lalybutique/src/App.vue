<template>
  <nav>
    <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link> |
    <router-link to="/create">Crear</router-link> |
    <router-link to="/read">Productos</router-link> |
    <a href="http://localhost/test/">asd</a> |
    <router-link to="/upload">Imagen</router-link>
  </nav>
  <router-view/>
  <!-- <div id="app">
  <img class="vue-logo" src="./assets/logo.png" />
  <cl-upload class="align" />
  </div> -->
</template>
<script>
import CloudinaryUpload from './components/CloudinaryUpload';
export default{
  name: "App",
  components:{
      "cl-upload": CloudinaryUpload
  }
};
</script>
<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
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
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
