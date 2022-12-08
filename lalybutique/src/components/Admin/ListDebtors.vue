<template>
    <body>
    <h1 style="text-align:center">DEUDORES</h1>
    <div class="container">
        <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped" style="background-color:rgb(192, 145, 244); color:black">
                <thead>
                    <tr>
                        <th scope="col">RUT</th>
                        <th scope="col">NOMBRE</th>
                        <th scope="col">APELLIDO</th>
                        <th scope="col">DIRECCION</th>
                        <th scope="col">TELEFONO</th>
                        <th scope="col">DEUDA</th>
                    </tr>
                </thead>
                <tbody v-for="deudor in deudores" :key="deudor.rut">
                        <td>{{deudor.rut}}</td>
                        <td>{{deudor.nombre}}</td>
                        <td>{{deudor.apellido}}</td>
                        <td>{{deudor.direccion}}</td>
                        <td>{{deudor.telefono}}</td>
                        <td>${{deudor.deuda}}</td>
                        <!-- <td>
                            <div class="btn-group" role="group" aria-label="">
                                <router-link :to="{ name: 'Sale', params: { id: venta.id_venta },}" class="btn btn-success">Detalle</router-link>
                            <router-link :to="{ name: 'EditTrackingNumber', params: { id: venta.id_venta },}" class="btn btn-info">Cod</router-link>
                            </div>
                            </td> -->
                </tbody>
            </table>
        </div>
        
        </div>
    </div>
    </body>
</template>
<script>
import axios from 'axios';
export default {
    data(){
        return{
            deudores:{}
        }
    },
    beforeMount(){
        this.ObtenerDeudores();
    },
    methods:{
        ObtenerDeudores(){
            let url = 'http://localhost/test/?deudores';
            axios.get(url).then((datosRespuesta)=>(this.deudores = datosRespuesta.data
            ),
            );
        }
    }
}
</script>