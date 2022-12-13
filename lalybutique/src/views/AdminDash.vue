<template>
    <div class="b">
        <div >
        <ul class="list-group list-group-flush">
            <!-- <li class="listdash"> <router-link to="/admin/Dashboard/Sales">Ventas</router-link></li> -->
            <a class="listdash" id="nava"><router-link to="/admin/Dashboard/Sales">Ventas</router-link> </a>
            <a class="listdash"><router-link to="/admin/Dashboard/Deudores">Deudores</router-link> </a>
        </ul>
</div>
    </div>
</template>
<script>
export default {
    mounted(){
  if(!localStorage.getItem('admin_token')){
      window.location.href='/Login'
  }
  },
}
</script>
<style>
    div.b {
  position: absolute;
  left: auto;
  width: 20%;
  height: 120px;
  background: #f8f9fa;
  /* border: 3px solid blue; */
} 
/* li.listdash{
    position: relative;
    display: block;
    padding: 0.75rem 1.25rem;
    background-color: #fff;
    border: 1px solid rgba(0,0,0,.125);
}
li.listdash a:hover{

    background-color:black;
   
}

*/
.listdash:hover{
    /* box-shadow: 3px 3px 3px #be7af0; */
    color: #be7af0;
    transform:scale(1.2);
}

.listdash{
  height:auto;
  width:auto;
  /* border:1px solid black; */
  transition:.3s;
  margin-left: auto;
  margin-right: auto;
  padding: 8px 30px;
  display: block;
}
/* ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 25%;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}

li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}

li a.active {
  background-color: #04AA6D;
  color: white;
} */

</style>