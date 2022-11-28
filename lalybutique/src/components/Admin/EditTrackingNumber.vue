<template>
    <div>
        <form v-on:submit.prevent="upload">
            <div class="mb-3">
                <label for="idventa" class="form-label">Id de venta: </label>
                <input type="text"
                    class="form-control" disabled="disabled" name="idventa" v-model="detail.id" id="idventa" aria-describedby="helpId" >
            </div>
            <div class="mb-3">
                <label for="Codigo" class="form-label">Codigo de seguimiento: </label>
                <input type="text"
                    class="form-control" name="Codigo" minlength="1" maxlength="40" v-model="detail.cod_seguimiento" id="Codigo" aria-describedby="helpId" >
                <small id="helpId" class="form-text text-muted">Ingresa el codigo de seguimiento</small>
            </div>
            <div class="btn-group" role="group" aria-label="">
                <button type="submit" @click="SubmitCod()" class="btn btn-success">Modificar</button>
                <router-link :to="{name:'Sales'}" class="btn btn-warning">Cancelar </router-link>
            </div>
        </form>
    </div>
</template>
<script>
import axios from 'axios';
// import axios from 'axios';
export default {
    data(){
        return{
            detail:{}
        }
    },
    created:function(){
        this.ObtenerDetalle();
    },
    methods:{
        ObtenerDetalle(){
            let url = 'http://localhost/test/?detalleV='+this.$route.params.id;
            axios.get(url).then((datosRespuesta)=>(
                this.detail = datosRespuesta.data[0]
                ));
        },
        SubmitCod(){
            if(this.detail.cod_seguimiento == ""){
                this.detail.cod_seguimiento = "No tiene"
            }
            let url = 'http://localhost/test/?modCod='+this.$route.params.id;
            var datosEnviar = {id: this.detail.id, rut: this.detail.rut, total: this.detail.total, estado: this.detail.estado, codSeg: this.detail.cod_seguimiento,fecha : this.detail.fecha}
            axios.post(url,datosEnviar).then((datosRespuesta)=>{
                if(datosRespuesta.data.success==1){
                    console.log('ready');
                    window.location.href='../../Sales';
                }
            })
        }
    }
}
</script>