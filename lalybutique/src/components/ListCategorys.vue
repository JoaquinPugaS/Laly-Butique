<template>
    <div style="text-align:left">
    <b><i>

        Categorias:
    </i></b>
    
        <ul>
            <li id= 'lateralMenu' v-for="tipo in tipos" :key="tipo.id">
            <b><i>

                
                <router-link
                :to="{name: 'categorias', params: {id:tipo.id},}">
                {{tipo.nombre}}
                </router-link>
            </i>
            </b>
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
<style scoped>
li{
    color: black;
    text-decoration: none;

    
}





</style>

