<template>
    <div v-if="session== false">
        <form v-on:submit.prevent="Login">
            <input type="text" id="username" class="fadeIn second" required name="username" v-model="usuario.username" placeholder="Nombre de usuario">
            <input type="password" id="password" class="fadeIn third"  required name="password" v-model="usuario.password" placeholder="Contraseña">
            <input type="submit" class="fadeIn fourth" value="Entrar">
            <div class="alert alter-danger" role="alert" v-if="error">
                Error, Nombre de usuario o contraseña Incorrectos..
            </div>
        </form>
        <a @click="invitado()">Si Quieres comprar como invitado click aquí</a>
    </div>
    <div v-if="datos == true">
        <form>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" aria-describedby="emailHelp" v-model="datosUser.nombre">
                <!-- <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div> -->
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">Apellido</label>
                <input type="text" class="form-control" id="apellido" aria-describedby="emailHelp" v-model="datosUser.apellido">
                <!-- <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div> -->
            </div>
            <div class="mb-3">
                <label for="rut" class="form-label">Rut</label>
                <input type="text" class="form-control" id="rut" aria-describedby="emailHelp" v-model="datosUser.rut" >
                <!-- <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div> -->
            </div>
            <div class="mb-3">
                <label for="Email" class="form-label">E-mail</label>
                <input type="email" class="form-control" id="Email" v-model="datosUser.email">
            </div>
            <div class="mb-3">
                <label for="Telefono" class="form-label">Teléfono</label>
                <input type="text" class="form-control" id="Telefono" v-model="datosUser.telefono">
            </div>
            <button type="submit" @click="webPayf()" class="btn btn-primary">Confirmar</button>
        </form>
    </div>
        <form v-if="final == true" method="post" action="https://webpay3gint.transbank.cl/webpayserver/initTransaction">
            <input type="hidden" name="token_ws" value="{{this.tokenn}}" />
            <input type="submit" value="Ir a pagar" />
        </form>
</template>
<script>
// eslint-disable-next-line
const url = '';
import { WebpayPlus } from 'transbank-sdk'; // ES6 Modules
import { Options, IntegrationApiKeys, Environment, IntegrationCommerceCodes } from 'transbank-sdk';
import axios from 'axios';
    export default{
        data(){
            return{
                usuario:[],
                error: false,
                session: false,
                datos: false,
                datosUser:{},
                tokenn : '',
                final: false,
            }
        },
        beforeMount(){
        if(localStorage.getItem('user_token') && localStorage.getItem('user_rut')){
            this.session = true;
            this.datos = true;
            this.ObtenerDatosUser();
        }
    },
        methods:{
            Login: function(){
                this.EnviarDatos();
                },
            webPayf: function(){
                this.webPay();
            },
            async webPay(){
            this.datos = false;
            this.final = true;
            const tx = new WebpayPlus.Transaction(new Options(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY, Environment.Integration))
            const buyorder = 'Laly-ASDJKH32ASH3';
            const sessionId = localStorage.getItem('user_token');
            const returnUrl = 'https://google.cl'  
            // eslint-disable-next-line
            const response = await tx.create(buyorder, sessionId, this.cart_total, returnUrl);
            console.log('pasó')
            console.log(response)
            this.tokenn = response.token
            // localStorage.setItem('url',response.url);
            // localStorage.setItem('token',response.token);
            // chrome.exe --user-data-dir="C://Chrome dev session" --disable-web-security
            },
            EnviarDatos(){
                var datosEnviar={username:this.usuario.username,password:this.usuario.password}
                let url = 'http://localhost/test/?login=1';
                axios.post(url,datosEnviar)
                .then((datosRespuesta=>{
                if(datosRespuesta.data.success===2){
                    localStorage.setItem('user_token', datosRespuesta.data.token);
                    localStorage.setItem('user_rut', datosRespuesta.data.rut);
                }else{
                    console.log('Error');
                    this.error = true;
                    }
                }))
            },
            invitado(){
                this.datos =true;
            },
            ObtenerDatosUser(){
            fetch('http://localhost/test/?consultaruser='+localStorage.getItem('user_rut'))
            .then(respuesta=>respuesta.json())
            .then((datosRespuesta)=>{
                // console.log(datosRespuesta)
                this.datosUser=datosRespuesta[0];
                })
            },
        },
        computed:{
            cart_total(){
                return this.$store.getters.cartTotal
        },
        }
}

</script>