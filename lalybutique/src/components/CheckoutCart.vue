<template>
    <div v-if="session== false">
        <form v-on:submit.prevent="Login">
            <input type="text" id="username" class="fadeIn second" minlength="3" maxlength="254" required name="username" v-model="usuario.username" placeholder="Nombre de usuario">
            <input type="password" id="password" class="fadeIn third" maxlength="24" required name="password" v-model="usuario.password" placeholder="Contraseña">
            <input type="submit" class="fadeIn fourth" value="Entrar">
            <div class="alert alter-danger" role="alert" v-if="error">
                Error, Nombre de usuario o contraseña Incorrectos..
            </div>
        </form>
        <a @click="invitado()">Si Quieres comprar como invitado click aquí</a>
    </div>
    <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="errorRut">
        Error, el rut no es valido...
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="errorEmail">
        Error, el email no es valido...
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <div v-if="datos == true">
        <form v-on:submit.prevent="webPayf" >
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" minlength="1" maxlength="30" required class="form-control" id="nombre" aria-describedby="emailHelp" v-model="datosUser.nombre">
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">Apellido</label>
                <input type="text" minlength="1" maxlength="30" required  class="form-control" id="apellido" aria-describedby="emailHelp" v-model="datosUser.apellido">
            </div>
            <div class="mb-3">
                <label for="rut" class="form-label">Rut</label>
                <input type="text" minlength="8" maxlength="9" required class="form-control" id="rut" aria-describedby="emailHelp" v-model="datosUser.rut" >
            </div>
            <div class="mb-3">
                <label for="Email" class="form-label">E-mail</label>
                <input type="email" minlength="3" maxlength="254" required class="form-control" id="Email" v-model="datosUser.email">
            </div>
            <div class="mb-3">
                <label for="Direccion" class="form-label">Direccion</label>
                <input type="text" minlength="1" maxlength="100" required class="form-control" id="Direccion" aria-describedby="emailHelp" v-model="datosUser.direccion" >
            </div>
            <div class="mb-3">
                <label for="Telefono" class="form-label">Teléfono</label>
                <input type="text" required minlength="9" maxlength="9" class="form-control" id="Telefono" v-model="datosUser.telefono">
            </div>
            <button id="bConfirmar" class="btn btn-primary">Confirmar</button>
        </form>
    </div>
    <form v-if="datos==true" method="post" action="https://webpay3gint.transbank.cl/webpayserver/init_transaction.cgi">
        <input type="hidden"  name="token_ws" v-model="respuesta.token" />
        <input type="submit" id="bWebpay" disabled value="Ir a pagar" />
    </form>
</template>
<script>
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
                datosUser:[],
                respuesta : {},
                final: false,
                errorRut: false,
                errorEmail: false,
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
            // this.datos = false;
            this.final = true;
            var rValidado = this.ValidarRut(this.datosUser.rut);
            if(rValidado == 'error2'){
                this.errorRut = true;
            }else{
                let patron = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
                if(!this.datosUser.email.match(patron)){
                    this.errorEmail = true;
                }else{
                    const tx = new WebpayPlus.Transaction(new Options(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY, Environment.Integration))
                    const orden = localStorage.getItem('cod_venta');
                    const buyorder = 'Laly Boutique-'+orden;
                    var sessionId = 0;
                    if(!localStorage.getItem('user_token')){
                        sessionId = Math.random().toString(36).substr(2);
                        localStorage.setItem('user_token1',sessionId);
                    }else{
                        sessionId = localStorage.getItem('user_token');
                    }
                    const returnUrl = 'http://localhost:3000/confirmacion/'  
                    const response = await tx.create(buyorder, sessionId, this.cart_total, returnUrl);
                    this.respuesta = response
                    const nombre = this.datosUser.nombre + " " + this.datosUser.apellido
                    var datos={rut:this.datosUser.rut, nombre:nombre, direccion: this.datosUser.direccion};
                    localStorage.setItem('datos',JSON.stringify(datos))
                    // chrome.exe --user-data-dir="C://Chrome dev session" --disable-web-security
                    const button = document.querySelector('#bWebpay');
                        button.disabled = false;
                    const button1 = document.querySelector('#bConfirmar');
                        button1.disabled = true;
                    const input_nombre = document.querySelector('#nombre');
                        input_nombre.disabled = true;
                    const input_apellido = document.querySelector('#apellido');
                        input_apellido.disabled = true;
                    const input_rut = document.querySelector('#rut');
                        input_rut.disabled = true;
                    const input_Email = document.querySelector('#Email');
                        input_Email.disabled = true;
                    const input_Telefono = document.querySelector('#Telefono');
                        input_Telefono.disabled = true;
                    const input_Direccion = document.querySelector('#Direccion');
                        input_Direccion.disabled = true;
                }
            }
            },
            EnviarDatos(){
                var datosEnviar={username:this.usuario.username,password:this.usuario.password}
                let url = 'http://localhost/test/?login=1';
                axios.post(url,datosEnviar)
                .then((datosRespuesta=>{
                if(datosRespuesta.data.success===2){
                    localStorage.setItem('user_token', datosRespuesta.data.token);
                    localStorage.setItem('user_rut', datosRespuesta.data.rut);
                    this.ObtenerDatosUser();
                    this.datos = true;
                    this.session = true;
                }else{
                    console.log('Error');
                    this.error = true;
                    }
                }))
            },
            invitado(){
                this.datos =true;
                this.session = true;
            },
            ObtenerDatosUser(){
            fetch('http://localhost/test/?consultaruser='+localStorage.getItem('user_rut'))
            .then(respuesta=>respuesta.json())
            .then((datosRespuesta)=>{
                this.datosUser=datosRespuesta[0];
                })
            },
            ValidarRut(rut){
                var valor = rut;
                // Aislar Cuerpo y Dígito Verificador
                var cuerpo = valor.slice(0,-1);
                var dv = valor.slice(-1).toUpperCase();
                
                // Formatear RUN
                rut = cuerpo + '-'+ dv
                
                // Si no cumple con el mínimo ej. (n.nnn.nnn)
                if(cuerpo.length < 7) { /*rut.setCustomValidity("RUT Incompleto");*/ return 'error1';}
                
                // Calcular Dígito Verificador
                var suma = 0;
                var multiplo = 2;
                
                // Para cada dígito del Cuerpo
                for(var i=1;i<=cuerpo.length;i++) {
                
                    // Obtener su Producto con el Múltiplo Correspondiente
                    var index = multiplo * valor.charAt(cuerpo.length - i);
                    
                    // Sumar al Contador General
                    suma = suma + index;
                    
                    // Consolidar Múltiplo dentro del rango [2,7]
                    if(multiplo < 7) { multiplo = multiplo + 1; } else { multiplo = 2; }
                }
                
                // Calcular Dígito Verificador en base al Módulo 11
                var dvEsperado = 11 - (suma % 11);
                
                // Casos Especiales (0 y K)
                dv = (dv == 'K')?10:dv;
                dv = (dv == 0)?11:dv;
                
                // Validar que el Cuerpo coincide con su Dígito Verificador
                if(dvEsperado != dv) { /*rut.setCustomValidity("RUT Inválido");*/ return 'error2'; }
            }
        },
        computed:{
            cart_total(){
                return this.$store.getters.cartTotal
            },
        }
}

</script>