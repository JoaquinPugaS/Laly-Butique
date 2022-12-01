<template>
    <div id="Login">

    </div>
        <div class="wrapper fadeInDown">
    <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
        <br>
        <img src="../assets/logo2.png" id="icon" alt="User Icon" />
        <br>
    </div>

    <!-- Login Form -->
    <form v-on:submit.prevent="Register">
        <label for="nombre" >Nombre</label>
        <input type="text" id="nombre" class="fadeIn second" required name="nombre" v-model="usuario.nombre" >
        <label for="apellido" >Apellido</label>
        <input type="text" id="apellido" class="fadeIn second" required name="apellido" v-model="usuario.apellido" >
        <label for="rut" >RUT</label>
        <input type="text" id="rut" class="fadeIn second" required name="rut" v-model="usuario.rut" >
        <label for="email" >E-mail</label>
        <input type="mail" id="email" class="fadeIn second" required name="email" v-model="usuario.email" >
        <label for="direccion" >Direccion</label>
        <input type="text" id="direccion" class="fadeIn second" required name="direccion" v-model="usuario.direccion" >
        <label for="telefono" >Teléfono</label>
        <input type="text" id="telefono" class="fadeIn second" required name="telefono" v-model="usuario.telefono" >
        <div>
        <label for="Contraseña" >Contraseña</label>
        <input type="password" id="password" class="fadeIn third"  required name="password"  v-model="usuario.password" >
        <label for="confirm-password" >Repite la contraseña</label>
        <input type="password" id="confirm-password" class="fadeIn third"  required name="confirm-password"  v-model="usuario.confirmpassword" >

        </div>
        <input type="submit" class="fadeIn fourth" value="Registrarse">
    </form>
        <div class="alert alter-danger" role="alert" v-if="error1">
                Error, el rut ingresado ya se encuentra registrado en el sistema...
        </div>
        <div class="alert alter-danger" role="alert" v-if="error2">
                Error, el E-mail ingresado ya se encuentra registrado en el sistema...
        </div>
    </div>
</div>
</template>
<script>
import axios from 'axios';
export default {
    data(){
        return{
            usuario:[],
            error1: false,
            error2: false,
        }
    },
    methods:{
        Register: function(){
            this.Registro();
        },
        Registro(){
            var datosEnviar={nombre:this.usuario.nombre,apellido:this.usuario.apellido,rut:this.usuario.rut,email:this.usuario.email,direccion:this.usuario.direccion,telefono:this.usuario.telefono,contraseña:this.usuario.password};
            let url = 'http://localhost/test/?RegistrarUser=1';
            axios.post(url,datosEnviar).then((datosRespuesta=>{
                if(datosRespuesta.data.success===1){
                    localStorage.setItem('user_token', datosRespuesta.data.token);
                    localStorage.setItem('user_rut', this.usuario.rut);
                    window.location.href='/'
                }
                // if(datosRespuesta.data.success===2){
                //     this.error1 = true;
                // }
                if(datosRespuesta.data.success===3){
                    this.error2 = true;
                }
            }))
        }
    }
}
</script>