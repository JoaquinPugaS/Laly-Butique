<template>
    <div class="container">
    <div class="card">
        <div class="card-header">
            Editar Productos
        </div>
        <div class="card-body" style="text-align: left">
            <form v-on:submit.prevent="upload" >
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre: </label>
                    <input type="text"
                        class="form-control"  name="nombre" v-model="producto.nombre" id="nombre" aria-describedby="helpId" placeholder="Nombre">
                    <small id="helpId" class="form-text text-muted">Ingresa el nombre del producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock" class="form-label">Stock: </label>
                    <input type="number"
                        class="form-control"  name="stock" v-model="producto.stock" id="stock" aria-describedby="helpId" placeholder="Stock">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock del producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock_critico" class="form-label">Stock Critico: </label>
                    <input type="number"
                        class="form-control"  name="stock_critico" v-model="producto.stock_critico" id="stock_critico" aria-describedby="helpId" placeholder="Stock critico">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock critico del producto</small>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio: </label>
                    <input type="number"
                        class="form-control"  name="precio" v-model="producto.precio" id="precio" aria-describedby="helpId" placeholder="Precio">
                    <small id="helpId" class="form-text text-muted">Ingresa el Precio del producto</small>
                </div>
                <div class="mb-3" id="uploadImage">
                    <label for="imagen" class="form-label">Imagen: </label>
                    <input type="file"
                        class="form-control" required name="imagen" id="file-input" aria-describedby="helpId" placeholder="imagen" accept="image/png, image/jpeg, image/jpg" @change="handleFileChange($event)">
                </div>
                <div class="mb-3">
                    <label for="estado" class="form-label">Estado: </label>
                    <input type="number"
                        class="form-control"  name="estado" v-model="producto.estado" id="estado" aria-describedby="helpId" placeholder="Estado">
                    <small id="helpId" class="form-text text-muted">Ingresa el Estado del producto</small>
                </div>
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success">Modificar</button>
                    <router-link :to="{name:'read'}" class="btn btn-warning">Cancelar </router-link>
                </div>
            </form>
        </div>
    </div>
    </div>
</template>
<script>
var urll = " ";
import axios from "axios";
export default {
    data(){
        return{
            producto:{}
        }

    },
    created:function(){
        this.obtenerInformacionID();
    },
    methods:{
        obtenerInformacionID(){
            fetch('http://localhost/test/?consultar='+this.$route.params.id)
            .then(respuesta=>respuesta.json())
            .then((datosRespuesta)=>{
                console.log(datosRespuesta)
                this.producto=datosRespuesta[0];
                
        })
    },
    ModificarProducto(urla){
        this.urll = urla;

        var datosEnviar={id:this.$route.params.id,nombre:this.producto.nombre,stock:this.producto.stock,stock_critico:this.producto.stock_critico,precio:this.producto.precio,imagen:this.urll,estado:this.producto.estado}
        fetch('http://localhost/test/?modificar='+this.$route.params.id,{
            method:'POST',
            body:JSON.stringify(datosEnviar)
        })
        .then(respuesta=>respuesta.json())
        .then((datosRespuesta=>{
            console.log(datosRespuesta);
            window.location.href='../read'
        }))
    },
            handleFileChange: function(event) {
            console.log("handlefilechange", event.target.files);
            this.file = event.target.files[0];
            this.filesSelected = event.target.files.length;
        },
        prepareFormData: function() {
            var preset = 'vue-upload';
            this.formData = new FormData();
            this.formData.append("upload_preset", preset);
            this.formData.append("tags", this.tags); 
            this.formData.append("file", this.fileContents);
        },
        upload: function() {
            console.log("upload", this.file.name);
            let reader = new FileReader();
            reader.addEventListener(
                "load",
                function() {
                this.fileContents = reader.result;
                this.prepareFormData();
                let cloudinaryUploadURL = `https://api.cloudinary.com/v1_1/dcmca9cgi/upload`;
                let requestObj = {
                    url: cloudinaryUploadURL,
                    method: "POST",
                    data: this.formData,
                    onUploadProgress: function(progressEvent) {
                    console.log("progress", progressEvent);
                    this.progress = Math.round(
                        (progressEvent.loaded * 100.0) / progressEvent.total
                    );
                    console.log(this.progress);
                    }.bind(this)
                };
                this.showProgress = true;
                axios(requestObj)
                    .then(response => {
                    this.results = response.data;
                    console.log(this.results);
                    console.log("public_id", this.results.public_id);
                    console.log("URL",this.results.url);
                    urll = this.results.url;
                    this.ModificarProducto(urll);
                    })
                    .catch(error => {
                    this.errors.push(error);
                    console.log(this.error);
                    })
                    .finally(() => {
                    setTimeout(
                        function() {
                        this.showProgress = false;
                        }.bind(this),
                        1000
                    );
                    });
                }.bind(this),
                false
            );
            if (this.file && this.file.name) {
                reader.readAsDataURL(this.file);
            }
        }
    }
}
</script>