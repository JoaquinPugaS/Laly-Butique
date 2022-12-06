<template>
    <body>
    <h1 style="text-align:center">VENTAS</h1>
    <div class="container">
        <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped" style="background-color:rgb(192, 145, 244); color:black">
                <thead>
                    <tr>
                        <th scope="col">ID VENTA</th>
                        <th scope="col">TOTAL VENTA</th>
                        <th scope="col">ESTADO VENTA</th>
                        <th scope="col">CODIGO SEGUIMIENTO</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody v-for="venta in ventas" :key="venta.id_venta">
                        <td>{{venta.id_venta}}</td>
                        <td>${{venta.total_a_pagar}}</td>
                        <td>{{venta.estado_de_orden}}</td>
                        <td>{{venta.cod_seguimiento}}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="">
                                <router-link :to="{ name: 'Sale', params: { id: venta.id_venta },}" class="btn btn-success">Detalle</router-link>
                            <router-link :to="{ name: 'EditTrackingNumber', params: { id: venta.id_venta },}" class="btn btn-info">Cod</router-link>
                            </div>
                            </td>
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
            ventas: {}
        }
    },
    beforeMount(){
        this.ObtenerVentas();
    },
    methods:{
        ObtenerVentas(){
            let url = 'http://localhost/test/?ventas=1';
            axios.get(url).then((datosRespuesta)=>(this.ventas = datosRespuesta.data
            ),
            );
        }
    }
}
</script>