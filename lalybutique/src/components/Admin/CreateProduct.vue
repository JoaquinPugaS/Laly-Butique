<template>
    <div class="container">
    <div class="card">
        <div class="card-header">
            Agregar un producto
        </div>
        <div class="card-body" style="text-align: left">
            <form v-on:submit.prevent="upload" >
                <div class="alert alter-danger" role="alert" v-if="error">
                    Error, El nombre del producto ya existe en la base de datos
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre: </label>
                    <input type="text"
                        class="form-control" required minlength="1" maxlength="50" name="nombre" v-model="producto.nombre" id="nombre" aria-describedby="helpId" placeholder="Nombre">
                    <small id="helpId" class="form-text text-muted">Ingresa el nombre del producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock" class="form-label">Stock: </label>
                    <input type="number"
                        class="form-control" required min="1" max="9999"  name="stock" v-model="producto.stock" maxlength="4"  id="stock" aria-describedby="helpId" placeholder="Stock">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock del producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock_critico" class="form-label">Stock Critico: </label>
                    <input type="number"
                        class="form-control" required min="1" max="99" name="stock_critico" v-model="producto.stock_critico" id="stock_critico" aria-describedby="helpId" placeholder="Stock critico">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock critico del producto</small>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio: </label>
                    <input type="number" min="1" max="999999999"
                        class="form-control" required  name="precio" v-model="producto.precio" id="precio" aria-describedby="helpId" placeholder="Precio">
                    <small id="helpId" class="form-text text-muted">Ingresa el Precio del producto</small>
                </div>
                <div class="mb-3" id="uploadImage">
                    <label for="imagen" class="form-label">Imagen: </label>
                    <input type="file"
                        class="form-control" name="imagen" id="file-input" aria-describedby="helpId" placeholder="imagen" accept="image/png, image/jpeg, image/jpg" @change="handleFileChange($event)">
                </div>
                <div class="mb-3">
                    <label for="estado" class="form-label">Estado: </label> <br>
                    <Listbox v-model="EstadoSeleccionado">
                        <ListboxButton>{{ EstadoSeleccionado.nombre }}</ListboxButton>
                        <ListboxOptions>
                            <ListboxOption 
                            v-for="estado in estados"
                            :key="estado.id" 
                            :value="estado" 
                            :disabled="estado.nodisponible"
                            >
                                {{estado.nombre}}
                            </ListboxOption>
                        </ListboxOptions>
                    </Listbox>
                    <br>
                    <small id="helpId" class="form-text text-muted">Ingresa el Estado del producto</small>
                </div>
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success">Añadir</button>
                    <router-link :to="{name:'ListProducts'}" class="btn btn-warning">Cancelar </router-link>
                </div>
            </form>
        </div>
    </div>
    </div>
</template>
<script setup>
import {ref} from 'vue'
import{
    Listbox,
    ListboxButton,
    ListboxOptions,
    ListboxOption,
} from '@headlessui/vue'
const estados= [
    {id: 1, nombre: 'Disponible', nodisponible: false},
    {id: 2, nombre: 'No disponible', nodisponible: false},
    {id: 3, nombre: 'Agotado', nodisponible: false},
]
const estadoD=[
    {id: 0, nombre: 'Seleccione uno', nodisponible: false},

]
const EstadoSeleccionado = ref(estadoD[0])
</script>
<script>
var urll = " ";
// eslint-disable-next-line
var sw = 0;
import axios from "axios";
export default {
    data(){
        return{
            producto:{},
            error: false,
        }
    },
    mounted(){
    if(!localStorage.getItem('admin_token')){
        window.location.href='/Login'
    }
    },
    methods:{
        AñadirProducto(urla){
            this.urll = urla ;
            if(this.EstadoSeleccionado.nombre === 'Seleccione uno'){
                this.EstadoSeleccionado.nombre = 'Disponible'
            }
            this.producto.estado = this.EstadoSeleccionado.nombre
            console.log(this.producto);
            var datosEnviar={nombre:this.producto.nombre,stock:this.producto.stock,stock_critico:this.producto.stock_critico,precio:this.producto.precio,imagen:this.urll,estado:this.producto.estado}
            // fetch('http://localhost/test/?insertar=1',{
            //     method:'POST',
            //     body:JSON.stringify(datosEnviar)
            // })
            let url = 'http://localhost/test/?insertar=1';
            axios.post(url,datosEnviar)
            // .then(respuesta=>respuesta.json())
            .then((datosRespuesta=>{
                if(datosRespuesta.data.success===1){
                    window.location.href='ListProducts'
                }else{
                    console.log('Error');
                    this.error = true;
                }
            }))
        },
        handleFileChange: function(event) {
            console.log("handlefilechange", event.target.files);
            this.file = event.target.files[0];
            this.filesSelected = event.target.files.length;
            this.sw = 1;
        },
        prepareFormData: function() {
            var preset = 'vue-upload';
            this.formData = new FormData();
            this.formData.append("upload_preset", preset);
            this.formData.append("tags", this.tags); 
            this.formData.append("file", this.fileContents);
        },
        upload: function() {
            if(this.sw === 1){

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
                    urll = this.results.url;
                    console.log(urll)
                    this.AñadirProducto(urll);
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
            }else{
                this.AñadirProducto(urll);
            }
        }
    }
}
</script>