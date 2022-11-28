<template>
    <h1>VENTAS</h1>
    <div>
        <div>
        <div class="table-responsive">
            <table class="table table-primary">
                <thead>
                    <tr>
                        <th scope="col">ID VENTA</th>
                        <th scope="col">TOTAL VENTA</th>
                        <th scope="col">ESTADO VENTA</th>
                        <th scope="col">CODIGO SEGUIMIENTO</th>
                        <th scope="col">DETALLE</th>
                    </tr>
                </thead>
                <tbody v-for="venta in ventas" :key="venta.id_venta">
                        <td>{{venta.id_venta}}</td>
                        <td>${{venta.total_a_pagar}}</td>
                        <td>{{venta.estado_de_orden}}</td>
                        <td>{{venta.cod_seguimiento}}</td>
                        <td><router-link :to="{ name: 'Sale', params: { id: venta.id_venta },}" class="btn btn-success">Detalle</router-link></td>
                        <td><router-link :to="{ name: 'EditTrackingNumber', params: { id: venta.id_venta },}" class="btn btn-success">Cod</router-link></td>
                </tbody>
            </table>
        </div>
        
        </div>
    </div>
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