<template>
<div class="container">
        <div class="card">
            <div class="card-header">
                Tipos de productos
                <router-link :to="{ name: 'CreateType'}" class="btn btn-info">Agregar</router-link>

            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped" style="background-color:rgb(192, 145, 244); color:black">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">NOMBRE</th>
                                <th scope="col">ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="tipo in tipos" :key="tipo.id">
                                <td>{{tipo.id}}</td>
                                <td>{{tipo.nombre}}</td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="">
                                        <router-link :to="{ name: 'EditType', params: { id: tipo.id },}" class="btn btn-success">Editar</router-link>
                                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#Confirmar" v-on:click="BorrarTipo(tipo.id,false) ">Eliminar</button>
                                        <div class="modal fade" id="Confirmar" tabindex="-1" aria-labelledby="ConfirmarLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content" style="border-radius: 45px">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="ConfirmarLabel" style="Color:black">Confirmar</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h5 style="color:black">¿Desea eliminar el tipo de producto seleccionado?</h5>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" v-on:click="BorrarTipo('',true)" class="btn btn-success">Aceptar</button>
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
            </div>
            
        </div>
    </div>
<div class="modal fade" id="Error" tabindex="-1" aria-labelledby="ErrorLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Error, el tipo seleccionado no puede ser eliminado debido a que existe un producto asociado a este tipo...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="Refrescar()">Cerrar</button>
            </div>
        </div>
    </div>
</div>
<button  id="btnOpen" hidden  data-bs-toggle="modal" data-bs-target="#Error"></button>
</template>
<script>
import axios from 'axios'
var idd = '';
export default {
    data(){
        return{
            tipos:{}
        }
    },
    beforeMount(){
        if(localStorage.getItem('admin_token')){
            this.ObtenerTipos();
        }else{
            window.location.href='/Login'
        }
    },
    methods:{
        ObtenerTipos(){
            let url = 'http://localhost/test/?Tipos';
            axios.get(url).then((datosRespuesta =>{
                this.tipos = datosRespuesta.data;
            }))
        },
        BorrarTipo(id,conf){
            if(conf == false){
                idd = id
            }
            if(conf == true){
                this.confirmar(idd)
            }
            },
        confirmar(id){
            let url = 'http://localhost/test/?eliminarTipo='+id;
            axios.post(url)
            .then((datosRespuesta)=>{
                console.log(datosRespuesta.data.success)
                if(datosRespuesta.data.success===2){
                    this.clickButton();
                }else if(datosRespuesta.data.success===1){
                    window.location.href='TypesList'
                }
            })
            .catch(console.log)
        },
        clickButton() {
            var click_event = new CustomEvent('click');
            var btn_element = document.querySelector('#btnOpen');
            btn_element.dispatchEvent(click_event);
        },
        Refrescar(){
            window.location.href='TypesList'
        },
    }
}
</script>