<template>
    <!-- <div id="Login"> -->

    <!-- </div>
        <div class="wrapper fadeInDown">
    <div id="formContent"> -->
    <!-- Tabs Titles -->

    <!-- Icon -->
    <!-- <div class="fadeIn first">
        <br>
        <img src="../assets/logo2.png" id="icon" alt="User Icon" />
        <br>
    </div> -->

    <!-- Login Form -->
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
            <!-- <form v-on:submit.prevent="Login">
                <input type="text" id="username" class="fadeIn second" maxlength="254" required name="username" v-model="usuario.username" placeholder="Nombre de usuario">
                <input type="password" id="password" class="fadeIn third"   maxlength="24" required name="password" v-model="usuario.password" placeholder="Contraseña">
                <input type="submit" class="fadeIn fourth" value="Entrar">
                <div class="alert alter-danger" role="alert" v-if="error">
                    Error, Nombre de usuario o contraseña Incorrectos..
                </div>
            </form> -->
            
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
            <form v-on:submit.prevent="Register">
                <!-- <label for="nombre" >Nombre</label> -->
                <input type="text" id="nombre" class="fadeIn second" required minlength="1" maxlength="30" name="nombre" v-model="usuario.nombre" placeholder="Nombre">
                <!-- <label for="apellido" >Apellido</label> -->
                <input type="text" id="apellido" class="fadeIn second" required minlength="1" maxlength="30" name="apellido" v-model="usuario.apellido" placeholder="Apellidos">
                <!-- <label for="rut" >RUT</label> -->
                <input type="text" id="rut" class="fadeIn second" minlength="8" maxlength="9" required name="rut" v-model="usuario.rut" placeholder="Rut (sin puntos ni guion)" >
                <!-- <label for="email" >E-mail</label> -->
                <input type="mail" id="email" class="fadeIn second" minlength="3" maxlength="254" required name="email" v-model="usuario.email" placeholder="Email">
                <!-- <label for="direccion" >Direccion</label> -->
                <input type="text" id="direccion" class="fadeIn second" minlength="1" maxlength="100" required name="direccion" v-model="usuario.direccion" placeholder="Direccion">
                <!-- <label for="telefono" >Teléfono</label> -->
                <input type="text" id="telefono" class="fadeIn second" minlength="9" maxlength="9" required name="telefono" v-model="usuario.telefono" placeholder="Telefono de contacto">
                <div>
                <!-- <label for="Contraseña" >Contraseña</label> -->
                <input type="password" id="password" class="fadeIn third" minlength="8" maxlength="24" required name="password"  v-model="usuario.password" placeholder="Contraseña">
                <!-- <label for="confirm-password" >Repite la contraseña</label> -->
                <input type="password" id="confirm-password" class="fadeIn third" minlength="8" maxlength="24"  required name="confirm-password"  v-model="usuario.confirmpassword" placeholder="Confirme Contraseña">
                </div>
                <input type="submit" class="fadeIn fourth" value="Registrarse">
            </form>
            </div>
        </div>


<!-- </div> -->
<!-- </div> -->
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
                        this.error3 = true;
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
<style scoped>
    html {
      background-color: #56baed;
    }
    
    body {
      font-family: "Poppins", sans-serif;
      height: 100vh;
    }
    
    a {
      color: #be7af0;
      display:inline-block;
      text-decoration: none;
      font-weight: 400;
    }
    
    h2 {
      text-align: center;
      font-size: 16px;
      font-weight: 600;
      text-transform: uppercase;
      display:inline-block;
      margin: 40px 8px 10px 8px; 
      color: #cccccc;
    }
    
    
    
    /* STRUCTURE */
    
    .wrapper {
      display: flex;
      align-items: center;
      flex-direction: column; 
      justify-content: center;
      width: 100%;
      min-height: 100%;
      padding: 20px;
    }
    
    #formContent {
      -webkit-border-radius: 10px 10px 10px 10px;
      border-radius: 10px 10px 10px 10px;
      background: #fff;
      padding: 30px;
      width: 90%;
      max-width: 450px;
      position: relative;
      padding: 0px;
      -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
      box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
      text-align: center;
    }
    
    #formFooter {
      background-color: #f6f6f6;
      border-top: 1px solid #dce8f1;
      padding: 25px;
      text-align: center;
      -webkit-border-radius: 0 0 10px 10px;
      border-radius: 0 0 10px 10px;
    }
    
    
    
    /* TABS */
    
    h2.inactive {
      color: #cccccc;
    }
    
    h2.active {
      color: #0d0d0d;
      border-bottom: 2px solid #5fbae9;
    }
    
    
    
    /* FORM TYPOGRAPHY*/
    
    input[type=button], input[type=submit], input[type=reset]  {
      background-color: #be7af0;
      border: none;
      color: white;
      padding: 15px 80px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      text-transform: uppercase;
      font-size: 13px;
      -webkit-box-shadow: 0 10px 30px 0 rgba(173, 95, 233, 0.274);
      box-shadow: 0 10px 30px 0 rgba(122, 5, 255, 0.4);
      -webkit-border-radius: 5px 5px 5px 5px;
      border-radius: 5px 5px 5px 5px;
      margin: 5px 20px 40px 20px;
      -webkit-transition: all 0.3s ease-in-out;
      -moz-transition: all 0.3s ease-in-out;
      -ms-transition: all 0.3s ease-in-out;
      -o-transition: all 0.3s ease-in-out;
      transition: all 0.3s ease-in-out;
    }
    
    input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover  {
      /* background-color: #d396fb; */
      background-color: #6b00f7;
    }
    
    input[type=button]:active, input[type=submit]:active, input[type=reset]:active  {
      -moz-transform: scale(0.95);
      -webkit-transform: scale(0.95);
      -o-transform: scale(0.95);
      -ms-transform: scale(0.95);
      transform: scale(0.95);
    }
    
    input[type=text],[type=password],[type=mail] {
      background-color: #f6f6f6;
      border: none;
      color: #0d0d0d;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin: 5px;
      width: 85%;
      border: 2px solid #f6f6f6;
      -webkit-transition: all 0.5s ease-in-out;
      -moz-transition: all 0.5s ease-in-out;
      -ms-transition: all 0.5s ease-in-out;
      -o-transition: all 0.5s ease-in-out;
      transition: all 0.5s ease-in-out;
      -webkit-border-radius: 5px 5px 5px 5px;
      border-radius: 5px 5px 5px 5px;
    }
    
    input[type=text]:focus {
      background-color: #fff;
      border-bottom: 2px solid #be7af0;
    }
    
    input[type=text]:placeholder {
      color: #cccccc;
    }
    
    
    
    /* ANIMATIONS */
    
    /* Simple CSS3 Fade-in-down Animation */
    .fadeInDown {
      -webkit-animation-name: fadeInDown;
      animation-name: fadeInDown;
      -webkit-animation-duration: 1s;
      animation-duration: 1s;
      -webkit-animation-fill-mode: both;
      animation-fill-mode: both;
    }
    
    @-webkit-keyframes fadeInDown {
      0% {
        opacity: 0;
        -webkit-transform: translate3d(0, -100%, 0);
        transform: translate3d(0, -100%, 0);
      }
      100% {
        opacity: 1;
        -webkit-transform: none;
        transform: none;
      }
    }
    
    @keyframes fadeInDown {
      0% {
        opacity: 0;
        -webkit-transform: translate3d(0, -100%, 0);
        transform: translate3d(0, -100%, 0);
      }
      100% {
        opacity: 1;
        -webkit-transform: none;
        transform: none;
      }
    }
    
    /* Simple CSS3 Fade-in Animation */
    @-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
    @-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
    @keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
    
    .fadeIn {
      opacity:0;
      -webkit-animation:fadeIn ease-in 1;
      -moz-animation:fadeIn ease-in 1;
      animation:fadeIn ease-in 1;
    
      -webkit-animation-fill-mode:forwards;
      -moz-animation-fill-mode:forwards;
      animation-fill-mode:forwards;
    
      -webkit-animation-duration:1s;
      -moz-animation-duration:1s;
      animation-duration:1s;
    }
    
    .fadeIn.first {
      -webkit-animation-delay: 0.4s;
      -moz-animation-delay: 0.4s;
      animation-delay: 0.4s;
    }
    
    .fadeIn.second {
      -webkit-animation-delay: 0.6s;
      -moz-animation-delay: 0.6s;
      animation-delay: 0.6s;
    }
    
    .fadeIn.third {
      -webkit-animation-delay: 0.8s;
      -moz-animation-delay: 0.8s;
      animation-delay: 0.8s;
    }
    
    .fadeIn.fourth {
      -webkit-animation-delay: 1s;
      -moz-animation-delay: 1s;
      animation-delay: 1s;
    }
    
    /* Simple CSS3 Fade-in Animation */
    .underlineHover:after {
      display: block;
      left: 0;
      bottom: -10px;
      width: 0;
      height: 2px;
      background-color: #be7af0;
      content: "";
      transition: width 0.2s;
      
    }
    
    .underlineHover:hover {
      color: #0d0d0d;
    }
    
    .underlineHover:hover:after{
      width: 100%;
    }
    
    
    
    /* OTHERS */
    
    *:focus {
        outline: none;
    } 
    
    #icon {
      width:60%;
    }
    
    </style>