<template>
    LISTA DE PRODUCTOS
    <!-- <div id="categorias" >
        Tipos:
        <fieldset>
        <div  v-for="tipo in tipos" :key="tipo.id">
            <input type="radio" name="tipo" @click="mostrarTipos(tipo.id)" v-model="tipo.id">{{tipo.nombre}}
        </div>
            <input type="radio" name="tipo" @click="consultarProductos()">Todos

        </fieldset>
    </div> -->
    <list-categorys></list-categorys>
    <div class="Container">
        <div class="card" style="width: 18rem;display: inline-flex;margin-right: 20px;margin-bottom:20px" v-for="producto  in productos" :key="producto.id">
            <router-link :to="{ name: 'ProductDetail', params: { id: producto.id },}">
            <img v-bind:src="`${producto.imagen}`" class="card-img-top" alt="..." width="200" height="250" v-if="producto.imagen!= ' '">
            <img v-else src="../assets/noDisp.png" width="250" height="200" style="margin-rigth: 20px;margin-left: 20px" >
            <div class="card-body">
                <h5 class="card-title">{{producto.nombre}}</h5>
                <p class="card-text">${{producto.precio}}</p>
                <!-- <router-link :to="{ name: 'ProductDetail', params: { id: producto.id },}" class="btn btn-success">Ver mas</router-link> -->
            </div>
            </router-link>
        </div>
    </div>
</template>
<script>
import axios from "axios";
import ListCategorys from '@/components/ListCategorys.vue'

export default {
    components: {ListCategorys}
    ,data(){
        return{
            productos:[],
            tipos:{}
        }
    },
    created:function(){
        this.consultarProductos();
        // this.consultarTipos();
    },
    methods:{
        consultarProductos(){
            let url  = 'http://localhost/test/?listar';
            axios.get(url).then((datosRespuesta)=>(this.productos = datosRespuesta.data));
        },
        mostrarTipos(id){
            // console.log('ID: '+id);
            let url  = 'http://localhost/test/?consultarPorTipo='+id;
            axios.get(url).then((datosRespuesta)=>(this.productos = datosRespuesta.data));
            this.productos = this.productos.data.filter(item => item.id === id);
        }
    },
}
</script>