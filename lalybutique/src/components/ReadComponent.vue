<template>
    <div class="container">
        <div class="card">
            <div class="card-header">
                Productos
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped" style="background-color:rgb(192, 145, 244); color:black">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">NOMBRE</th>
                                <th scope="col">STOCK</th>
                                <th scope="col">STOCK CRITICO</th>
                                <th scope="col">PRECIO</th>
                                <th scope="col">ESTADO</th>
                                <th scope="col">ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="producto in productos" :key="producto.id">
                                <td>{{producto.id}}</td>
                                <td>{{producto.nombre}}</td>
                                <td>{{producto.stock}}</td>
                                <td>{{producto.stock_critico}}</td>
                                <td>{{producto.precio}}</td>
                                <td>{{producto.estado}}</td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="">
                                        <router-link :to="{ name: 'edit', params: { id: producto.id },}" class="btn btn-success">Editar</router-link>
                                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#Confirmar" v-on:click="borrarProducto(producto.id,false) ">Eliminar</button>
                                        <div class="modal fade" id="Confirmar" tabindex="-1" aria-labelledby="ConfirmarLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content" style="border-radius: 45px">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="ConfirmarLabel" style="Color:black">Confirmar</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <h5 style="color:black">¿Desea eliminar el producto seleccionado?</h5>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" v-on:click="borrarProducto('',true)" class="btn btn-success">Aceptar</button>
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
</template>
<script>
import axios from "axios";

// eslint-disable-next-line
var idd = ' ';
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
            // fetch('http://localhost/test/?leer')
            // .then(respuesta=>respuesta.json())
            let url  = 'http://localhost/test/?leer';
            axios.get(url).then((datosRespuesta)=>(this.productos = datosRespuesta.data));
            // .then((datosRespuesta)=>{
            //     console.log(datosRespuesta)
            //     this.productos=[]
            //     if(typeof datosRespuesta[0].success=== 'undefined' )
            //     {
            //         this.productos=datosRespuesta;
            //     }
            // })
            // .catch(console.log)
        },
        borrarProducto(id,conf){
            if(conf == false){
                this.idd = id
                console.log(this.idd)
            }
            if(conf == true){
                this.confirmar(this.idd)
            }

            },
        confirmar(id){
            let url = 'http://localhost/test/?eliminar='+id;
            // fetch('http://localhost/test/?eliminar='+id)
            // .then(respuesta=>respuesta.json())
            axios.post(url)
            .then((datosRespuesta)=>{
                console.log(datosRespuesta)
                window.location.href='read'
            })
            .catch(console.log)
        },
        modificarProducto(id){
            let url = 'edit'+id;
            // fetch('edit'+id)
            // .then(respuesta=>respuesta.json())
            axios.post(url)
            .then((datosRespuesta)=>{
                console.log(datosRespuesta)
                window.location.href='edit'
            })
            .catch(console.log)
            
        },

    }
}
</script>

