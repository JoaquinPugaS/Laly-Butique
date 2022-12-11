<template>
    <div class="container">
        <div class="card">
            <div class="card-header">
                Editar Tipo
            </div>
            <div class="card-body" style="text-align: left">
                <form v-on:submit.prevent="upload" >
                    <div class="alert alter-danger" role="alert" v-if="error">
                        Error, El nombre del tipo ya existe en la base de datos
                    </div>
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre: </label>
                        <input type="text"
                            class="form-control" required minlength="1" maxlength="50" name="nombre" v-model="tipo.nombre" id="nombre" aria-describedby="helpId" placeholder="Nombre">
                        <small id="helpId" class="form-text text-muted">Ingresa el nombre del tipo</small>
                    </div>
                    <div class="btn-group" role="group" aria-label="">
                        <button type="submit" class="btn btn-success" >Editar</button>
                        <router-link :to="{name:'ListProducts'}" class="btn btn-warning">Cancelar </router-link>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
export default {
    data(){
        return{
            tipo:{},
            error:false,
        }
    },
    beforeMount(){
    if(!localStorage.getItem('admin_token')){
        window.location.href='/Login'
    }
    },
    created:function(){
        this.ObtenerInformacionID();
    },
    methods:{
        upload: function(){
                this.ModificarTipo();
        },
        ObtenerInformacionID(){
        let url = 'http://localhost/test/?consultarTipo='+this.$route.params.id;
        axios.get(url)
        .then((datosRespuesta=>{
            console.log(datosRespuesta),
            this.tipo=datosRespuesta.data[0]
        }))
        },
        ModificarTipo(){
            var datosEnviar={id: this.tipo.id,nombre:this.tipo.nombre}
            let url = 'http://localhost/test/?modificarTipo='+this.$route.params.id;
            axios.post(url,datosEnviar)
            .then((datosRespuesta=>{
                if(datosRespuesta.data.success==1){
                    window.location.href="../TypesList"
                }else(
                    this.error = true
                )
            }))
        }
    }
}
</script>