<template>
    <div>
        <div>
        <div class="table-responsive">
            <table class="table table-primary">
                <thead>
                    <tr>
                        <th scope="col">ID PRODUCTO</th>
                        <th scope="col">CANTIDAD PRODUCTO</th>
                        <th scope="col">Precio unitario</th>
                    </tr>
                </thead>
                <tbody v-for="compra in compras" :key="compra.id_venta">
                        <td>{{compra.id_producto}}</td>
                        <td>{{compra.cantidad_producto}}</td>
                        <td>{{compra.precio_unitario}}</td>
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
        this.ObtenerDetalle();
    },
    methods:{
        ObtenerDetalle(){
            let url = "http://localhost/test/?DetalleCompra="+this.$route.params.id;
            axios.get(url).then((datosRespuesta)=>(this.compras = datosRespuesta.data));        }
    }
}

</script>