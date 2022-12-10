<template>
<a>{{respuesta}}</a>
<div v-if="aprobado==1">
    APROBADO
    <div style="text-align: left">
        Fecha: <a>{{respuesta.transaction_date}}</a><br>
        Nombre: <a>{{nombre}}</a><br>
        Rut: <a>{{rut}}</a><br>
        Direccion: <a>{{direccion}}</a><br>
        <br>
    </div>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Total</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="producto in productos" :key="producto.id">
                    <td scope="row">{{producto.id}}</td>
                    <td>{{producto.cantidad}}</td>
                    <td>{{producto.nombre}}</td>
                    <td>${{producto.precio}}</td>
                    <td>${{producto.precio * producto.cantidad}}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div style="text-align:right">
        Total a pagar: <a style="padding-right: 100px">${{cart_total}}</a>
    </div>
</div>
<div v-if="aprobado==0">
    RECHAZADO
</div>
</template>
<script>
import { WebpayPlus } from 'transbank-sdk'; // ES6 Modules
import { Options, IntegrationApiKeys, Environment, IntegrationCommerceCodes } from 'transbank-sdk';
import axios from 'axios';
const valores = window.location.search;
const urlParams = new URLSearchParams(valores);
var tokenn = urlParams.get('token_ws');
export default {
    data(){
        return{
            respuesta:{},
            aprobado: -1,
            nombre: '',
            rut: '',
            direccion: '',
        }
    }
    ,beforeMount(){
        this.ObtenerToken();
    }
    ,methods:{
        async ObtenerToken(){
        var datos = JSON.parse(localStorage.getItem('datos'));
        console.log(datos);
        this.rut = datos.rut
        this.nombre = datos.nombre
        this.direccion = datos.direccion
        const tx = new WebpayPlus.Transaction(new Options(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY, Environment.Integration));
        const response = await tx.commit(tokenn);
        this.respuesta = response
        if(this.respuesta.status=='AUTHORIZED' && this.respuesta.response_code == 0){
            this.aprobado = 1;
            var monto = this.respuesta.amount
            var fecha = this.respuesta.transaction_date
            var estado = 'Pagado'
            var id_venta = localStorage.getItem('cod_venta')
            var datosEnviar={id_venta:id_venta,rut:this.rut,total:monto,estado:estado,fecha:fecha,codseg:''}
            let url = 'http://localhost/test/?venta=1';
            console.log(datosEnviar)
            axios.post(url,datosEnviar)
            .then((datosRespuesta=>{
                if(datosRespuesta.data.success===1){
                    console.log('bien')
                }else{
                    console.log('error')
                }
            }))
            for(var i in this.productos){
                datosEnviar = {id: this.productos[i].id,cantidad:this.productos[i].cantidad};
                let url = "http://localhost/test/?restarProducto";
                console.log(datosEnviar);
                axios.post(url,datosEnviar).then((datosRespuesta=>{
                    if(datosRespuesta.data.success==1){
                        console.log('restado');
                    }
                    }
                ))
            }
            
        }else{
            this.aprobado = 0;
        }
        localStorage.clear();
        }
    }
    ,computed:{
            cart_total(){
                return this.$store.getters.cartTotal
            },
            productos(){
                return this.$store.getters.cartItems
            },
        }
}
</script>