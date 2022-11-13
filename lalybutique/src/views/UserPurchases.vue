<template>
    <div>
        <div>
        <div class="table-responsive">
            <table class="table table-primary">
                <thead>
                    <tr>
                        <th scope="col">ID COMPRA</th>
                        <th scope="col">TOTAL</th>
                        <th scope="col">ESTADO</th>
                        <th scope="col">CODIGO SEGUIMIENTO</th>
                        <th scope="col">DETALLE</th>
                    </tr>
                </thead>
                <tbody v-for="compra in compras" :key="compra.id_venta">
                        <td>{{compra.id_venta}}</td>
                        <td>{{compra.total_pago}}</td>
                        <td>{{compra.estado_orden}}</td>
                        <td>{{compra.codigo_seguimiento}}</td>
                        <td><router-link :to="{ name: 'PurchaseDetail', params: { id: compra.id_venta },}" class="btn btn-success">Detalle</router-link></td>
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
            compras:{}
        }
    },
    beforeMount(){
        this.ObtenerCompras();
    },
    methods:{
        ObtenerCompras(){
            var rut = localStorage.getItem('user_rut')
            let url = "http://localhost/test/?compras="+rut;
            axios.get(url).then((datosRespuesta)=>(this.compras = datosRespuesta.data));        }
    }
}

</script>