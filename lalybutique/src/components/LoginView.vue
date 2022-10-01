<template>
    <form v-on:submit.prevent="Login">
        <label for="username">Usuario:</label><br>
        <input type="text" required name="username" v-model="usuario.username" id="username"><br>
        <label for="password">Contrasenia:</label><br>
        <input type="password" required name="password" v-model="usuario.password" id="passowrd"><br><br>
        <input type="submit" value="Log In">
    </form>


</template>
<script>
    export default{
        data(){
            return{
                usuario:[]
            }
        },
        methods:{
            Login: function(){
                this.EnviarDatos();
                },
            EnviarDatos(){
                var datosEnviar={username:this.usuario.username,password:this.usuario.password}
                fetch('http://localhost/test/?login=1',{
                    method:'POST',
                    body:JSON.stringify(datosEnviar)
                })
                .then(respuesta=>respuesta.json())
                .then((datosRespuesta=>{
                    console.log(datosRespuesta.success)
                    if(datosRespuesta.success===1){
                        window.location.href='/'
                    }else{
                        console.log('Error');
                    }
                
                }))

            }
        }

    }

</script>