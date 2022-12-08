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
        <input type="text" id="nombre" class="fadeIn second" required minlength="1" maxlength="30" name="nombre" v-model="usuario.nombre" >
        <label for="apellido" >Apellido</label>
        <input type="text" id="apellido" class="fadeIn second" required minlength="1" maxlength="30" name="apellido" v-model="usuario.apellido" >
        <label for="rut" >RUT</label>
        <input type="text" id="rut" class="fadeIn second" minlength="8" maxlength="9" required name="rut" v-model="usuario.rut" >
        <label for="email" >E-mail</label>
        <input type="mail" id="email" class="fadeIn second" minlength="3" maxlength="254" required name="email" v-model="usuario.email" >
        <label for="direccion" >Direccion</label>
        <input type="text" id="direccion" class="fadeIn second" minlength="1" maxlength="100" required name="direccion" v-model="usuario.direccion" >
        <label for="telefono" >Teléfono</label>
        <input type="text" id="telefono" class="fadeIn second" minlength="9" maxlength="9" required name="telefono" v-model="usuario.telefono" >
        <div>
        <label for="Contraseña" >Contraseña</label>
        <input type="password" id="password" class="fadeIn third" minlength="8" maxlength="24" required name="password"  v-model="usuario.password" >
        <label for="confirm-password" >Repite la contraseña</label>
        <input type="password" id="confirm-password" class="fadeIn third" minlength="8" maxlength="24"  required name="confirm-password"  v-model="usuario.confirmpassword" >
        </div>
        <input type="submit" class="fadeIn fourth" value="Registrarse">
    </form>
        <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="error3">
            Error, las contraseñas deben coincidir...
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="error2">
            Error, el E-mail ingresado ya se encuentra registrado en el sistema...
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="error1">
                Error, el rut no es valido...
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="error4">
                Error, el email no es valido...
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
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
            error3: false,
            error4: false,
        }
    },
    methods:{
        Register: function(){
            this.Registro();
        },
        Registro(){
            var rut = this.ValidarRut(this.usuario.rut)
            if(rut == 'error2'){
                this.error1 = true;
            }else{
                let patron = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
                if(!this.usuario.email.match(patron)){
                    this.error4 =true;
                }else{
                    if(this.usuario.password != this.usuario.confirmpassword){
                        this.error1 = true;
                    }else{
                        var datosEnviar={nombre:this.usuario.nombre,apellido:this.usuario.apellido,rut:this.usuario.rut,email:this.usuario.email,direccion:this.usuario.direccion,telefono:this.usuario.telefono,contraseña:this.usuario.password};
                        let url = 'http://localhost/test/?RegistrarUser=1';
                        axios.post(url,datosEnviar).then((datosRespuesta=>{
                            if(datosRespuesta.data.success===1){
                                localStorage.setItem('user_token', datosRespuesta.data.token);
                                localStorage.setItem('user_rut', this.usuario.rut);
                                window.location.href='/'
                            }
                            if(datosRespuesta.data.success===3){
                                this.error2 = true;
                            }
                        }))
                    }
                }
            }
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
    }
}
</script>