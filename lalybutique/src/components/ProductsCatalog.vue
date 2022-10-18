<template>
    LISTA DE PRODUCTOS
    <div class="Container">
        <div class="card" style="width: 18rem;display: inline-flex;margin-right: 20px;margin-bottom:20px" v-for="producto  in productos" :key="producto.id">
            <img v-bind:src="`${producto.imagen}`" class="card-img-top" alt="..." width="200" height="200" v-if="producto.imagen!= ' '">
            <img v-else src="../assets/noDisp.png" width="250" height="200" style="margin-rigth: 20px;margin-left: 20px" >
            <div class="card-body">
                <h5 class="card-title">{{producto.nombre}}</h5>
                <p class="card-text">${{producto.precio}}</p>
                <router-link :to="{ name: 'ProductDetail', params: { id: producto.id },}" class="btn btn-success">Ver mas</router-link>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data(){
        return{
            productos:[]
        }
    },
    created:function(){
        this.consultarProductos();
    },
    methods:{
        consultarProductos(){
            let url  = 'http://localhost/test/?listar';
            axios.get(url).then((datosRespuesta)=>(this.productos = datosRespuesta.data));
        },
    }
}
</script>