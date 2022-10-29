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
        <form v-on:submit.prevent="Pagar">
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
            <button type="submit" class="btn btn-primary">Continuar</button>
        </form>
    </div>
</template>
<script>
// import { WebpayPlus } from 'transbank-sdk'; // ES6 Modules
// import { Options, IntegrationApiKeys, Environment, IntegrationCommerceCodes } from 'transbank-sdk';
import axios from 'axios';
    export default{
        data(){
            return{
                usuario:[],
                error: false,
                session: false,
                datos: false,
                datosUser:{},
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
            Pagar: function(){
                this.Pagar();
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
                console.log(datosRespuesta)
                this.datosUser=datosRespuesta[0];
                })
            },
            // Pagar(){
            //     const tx = new WebpayPlus.Transaction(new Options(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY, Environment.Integration));
            //     let buy_order = "Laly-boutique";
            //     const response = await tx.create(buy_order, sessionId, this.cart_total(), returnUrl);
            //     response.url
            //     response.token
            // }
            
        },
        computed:{
            cart_total(){
                return this.$store.getters.cartTotal
        },
        }
}

</script>