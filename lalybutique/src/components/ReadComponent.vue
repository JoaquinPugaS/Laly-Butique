<template>
    <div class="container">
        <div class="card">
            <div class="card-header">
                Productos
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-dark table-striped">
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
                                        <button type="button" class="btn btn-warning">Editar</button>
                                        <button type="button" v-on:click="borrarProducto(producto.id)" class="btn btn-danger">Eliminar</button>
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
            fetch('http://localhost/test/?leer')
            .then(respuesta=>respuesta.json())
            .then((datosRespuesta)=>{
                console.log(datosRespuesta)
                this.productos=[]
                if(typeof datosRespuesta[0].success=== 'undefined' )
                {
                    this.productos=datosRespuesta;
                }
            })
            .catch(console.log)
        },
        borrarProducto(id){
            fetch('http://localhost/test/?eliminar='+id)
            .then(respuesta=>respuesta.json())
            .then((datosRespuesta)=>{
                console.log(datosRespuesta)
                window.location.href='read'
            })
            .catch(console.log)
            
        }
    }
}
</script>

