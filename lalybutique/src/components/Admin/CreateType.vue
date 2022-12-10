<template>
    <div class="container">
        <div class="card">
            <div class="card-header">
                Agregar un tipo de producto
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
                        <button type="submit" class="btn btn-success" >Añadir</button>
                        <router-link :to="{name:'ListProducts'}" class="btn btn-warning">Cancelar </router-link>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios';

export default {
    data(){
        return{
            tipo:{},
            error: false,
        }
    },
    methods:{
        upload(){
                let url = 'http://localhost/test/?addTipo';
            var datosEnviar= {nombre: this.tipo.nombre};
            axios.post(url,datosEnviar).then((datosRespuesta=>{
                if(datosRespuesta.data.success===1){
                    window.location.href='ListProducts'
                }else if(datosRespuesta.data.success===2){
                    this.error = true;
                }
            }))
        }
    }
}
</script>