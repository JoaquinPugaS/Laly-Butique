<template>
    <div>
        <div>
        <div class="table-responsive">
            <table class="table table-primary">
                <thead>
                    <tr>
                        <th scope="col">ID PRODUCTO</th>
                        <th scope="col">NOMBRE PRODUCTO</th>
                        <th scope="col">CANTIDAD PRODUCTO</th>
                        <th scope="col">Precio unitario</th>
                    </tr>
                </thead>
                <tbody v-for="v in venta" :key="v.id_venta">
                        <td>{{v.id_producto}}</td>
                        <td>{{v.nombre}}</td>
                        <td>{{v.cantidad_producto}}</td>
                        <td>{{v.precio_unitario}}</td>
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
            venta:{}
        }
    },
    beforeMount(){
        this.ObtenerDetalle();
    },
    methods:{
        ObtenerDetalle(){
            let url = "http://localhost/test/?DetalleCompra="+this.$route.params.id;
            axios.get(url).then((datosRespuesta)=>(
                console.log(datosRespuesta),
                this.venta = datosRespuesta.data));        }
    }
}
</script>