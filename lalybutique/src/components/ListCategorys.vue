<template>
    <div class="cell">
        <ul>
            <li v-for="tipo in tipos" :key="tipo.id">
            <router-link
            :to="{name: 'categorias', params: {id:tipo.id},}">
            {{tipo.nombre}}
            </router-link>
            </li>
        </ul>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    name: 'ListCategorys',
    data(){
        return{
            tipos:{}
        }
    },
    methods:{
        CargarTipos: function(){
        let url = 'http://localhost/test/?Tipos';
        axios.get(url).then((datosRespuesta =>{
            this.tipos = datosRespuesta.data;
        }))
        },
    },
    beforeMount(){
        this.CargarTipos();
    }
}
</script>

