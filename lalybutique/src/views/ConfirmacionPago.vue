<template>
<a>{{respuesta}}</a>
<div v-if="aprobado==true">
    APROBADO
</div>
<div v-else>
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
            aprobado: true
        }
    }
    ,beforeMount(){
        this.ObtenerToken();
    }
    ,methods:{
        async ObtenerToken(){
        const tx = new WebpayPlus.Transaction(new Options(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY, Environment.Integration));
        const response = await tx.commit(tokenn);
        this.respuesta = response
        if(this.respuesta.status=='AUTHORIZED' && this.respuesta.response_code == 0){
            this.aprobado = true;
            var rut = localStorage.getItem('user_rut')
            var monto = this.respuesta.amount
            var fecha = this.respuesta.transaction_date
            var estado = 'Pagado'
            var datosEnviar={rut:rut,total:monto,estado:estado,fecha:fecha,codseg:''}
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
            
            
        }else{
            this.aprobado = false;
        }
        }
    }
    ,computed:{
            cart_total(){
                return this.$store.getters.cartTotal
            },
        }
}
</script>