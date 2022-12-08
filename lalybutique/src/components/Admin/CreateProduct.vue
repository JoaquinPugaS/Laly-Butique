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
                        class="form-control" name="imagen" id="file-input" aria-describedby="helpId" placeholder="imagen" accept="image/png, image/jpeg, image/jpg" @change="Test($event, 1)">
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
                <!-- <div>
                    <fieldset>
                    <legend>¿Desea añadir una variante?</legend>
                        <div>
                        <input type="radio" name="resp" id="si" v-model="variante" @click="radio()">
                        <label for="si">Si      </label>    |
                        <input type="radio" name="resp" id="no">
                        <label for="no">No</label>
                            <div v-if="variante">
                                <div class="mb-3">
                                    <label for="NombreVariante" class="form-label">Nombre de la variante: </label>
                                    <input type="text" minlength="1" maxlength="255"
                                        class="form-control" required  name="NombreVariante" v-model="variantes.nombre" id="NombreVariante" aria-describedby="helpId" placeholder="Nombre de la variante">
                                    <small id="helpId" class="form-text text-muted">Ingresa el nombre de la variante</small>
                                </div>
                                <div class="mb-3">
                                    <label for="CantidadVariante" class="form-label">Cantidad: </label>
                                    <input type="number" min="1" max="127"
                                        class="form-control" required  name="CantidadVariante" v-model="variantes.cantidad" id="CantidadVariante" aria-describedby="helpId" placeholder="Cantidad">
                                    <small id="helpId" class="form-text text-muted">Ingresa la cantidad</small>
                                </div>
                                <div class="mb-3">
                                    <label for="PrecioVariante" class="form-label">Precio: </label>
                                    <input type="number" min="1" max="999999999"
                                        class="form-control" required  name="PrecioVariante" v-model="variantes.precio" id="PrecioVariante" aria-describedby="helpId" placeholder="Precio">
                                    <small id="helpId" class="form-text text-muted">Ingresa el Precio</small>
                                </div>
                                <div class="mb-3" id="uploadImage">
                                    <label for="imagenVariante" class="form-label">Imagen: </label>
                                    <input type="file"
                                        class="form-control" name="imagenVariante" id="file-input" aria-describedby="helpId" placeholder="imagenVariante" accept="image/png, image/jpeg, image/jpg" @change="Test($event, 2)">
                                </div>
                                <legend>¿Desea añadir otra variante?</legend>
                                <input type="radio" name="resp" id="si" v-model="variante" @click="radio()">
                                <label for="si">Si      </label>    |
                                <input type="radio" name="resp" id="no">
                                <label for="no">No</label>
                                <div v-for="cantidad= 1 in cantVar" :key="cantidad.length">
                                    <div class="mb-3">
                                        <label for="NombreVariante" class="form-label">Nombre de la variante: </label>
                                        <input type="text" minlength="1" maxlength="255"
                                            class="form-control" required  name="NombreVariante" v-model="variantes.nombre" id="NombreVariante" aria-describedby="helpId" placeholder="Nombre de la variante">
                                        <small id="helpId" class="form-text text-muted">Ingresa el nombre de la variante</small>
                                    </div>
                                    <div class="mb-3">
                                        <label for="CantidadVariante" class="form-label">Cantidad: </label>
                                        <input type="number" min="1" max="127"
                                            class="form-control" required  name="CantidadVariante" v-model="variantes.cantidad" id="CantidadVariante" aria-describedby="helpId" placeholder="Cantidad">
                                        <small id="helpId" class="form-text text-muted">Ingresa la cantidad</small>
                                    </div>
                                    <div class="mb-3">
                                        <label for="PrecioVariante" class="form-label">Precio: </label>
                                        <input type="number" min="1" max="999999999"
                                            class="form-control" required  name="PrecioVariante" v-model="variantes.precio" id="PrecioVariante" aria-describedby="helpId" placeholder="Precio">
                                        <small id="helpId" class="form-text text-muted">Ingresa el Precio</small>
                                    </div>
                                    <div class="mb-3" id="uploadImage">
                                        <label for="imagenVariante" class="form-label">Imagen: </label>
                                        <input type="file"
                                            class="form-control" name="imagenVariante" id="file-input" aria-describedby="helpId" placeholder="imagenVariante" accept="image/png, image/jpeg, image/jpg" @change="Test($event, 2)">
                                    </div>
                                    <legend>¿Desea añadir otra variante?</legend>
                                    <input type="radio" name="resp" id="si" v-model="variante" @click="radio()">
                                    <label for="si">Si      </label>    |
                                    <input type="radio" name="resp" id="no">
                                    <label for="no">No</label>

                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div> -->
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success" @click="AñadirProducto()" >Añadir</button>
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
var urlV = " ";
var id = Math.floor((Math.random() * 1000) + 1);
import axios from "axios";
export default {
    data(){
        return{
            producto:{},
            error: false,
            variante: false,
            variantes: {},
            cantVar: 0,
            varianteEnviar:{},
        }
    },
    beforeMount(){
    if(!localStorage.getItem('admin_token')){
        window.location.href='/Login'
    }
    },
    methods:{
        radio: function(){
            this.Radio();
        },
        Radio(){
            this.cantVar ++;
            this.varianteEnviar={nombre: this.variantes.nombre, cantidad: this.variantes.cantidad, precio: this.variantes.precio};
            console.log(this.varianteEnviar.nombre)
            this.variante = true;
            this.ch1 = 1;
        },
        sleep(ms){
            return new Promise(resolve => setTimeout(resolve, ms));
        },
        AñadirProducto(){
            if(this.variante == true){
                var cod = this.id;
                var datosEnviar={codigo: cod,nombre: this.variantes.nombre, cantidad: this.variantes.cantidad, precio: this.variantes.precio, imagen: urlV}
                console.log(datosEnviar);
                let url = 'http://localhost/test/?insertarV=1';
                axios.post(url,datosEnviar)
                .then((datosRespuesta=>{
                    if(datosRespuesta.data.success===1){
                        id = datosRespuesta.data.codigo;
                    }else{
                        console.log('Error Variante');
                    }
                }))
                if(this.EstadoSeleccionado.nombre === 'Seleccione uno'){
                    this.EstadoSeleccionado.nombre = 'Disponible'
                }
                this.producto.estado = this.EstadoSeleccionado.nombre
                console.log(this.producto);
                datosEnviar={codigo: id,nombre:this.producto.nombre,stock:this.producto.stock,stock_critico:this.producto.stock_critico,precio:this.producto.precio,imagen:urll,estado:this.producto.estado}
                url = 'http://localhost/test/?insertar=1';
                axios.post(url,datosEnviar)
                .then((datosRespuesta=>{
                    if(datosRespuesta.data.success===1){
                        // window.location.href='ListProducts'
                        console.log('listo');
                    }else{
                        console.log('Error');
                        this.error = true;
                    }
                }))
            }else{
                console.log(urll);
                if(this.EstadoSeleccionado.nombre === 'Seleccione uno'){
                    this.EstadoSeleccionado.nombre = 'Disponible'
                }
                this.producto.estado = this.EstadoSeleccionado.nombre
                datosEnviar={codigo: 0,nombre:this.producto.nombre,stock:this.producto.stock,stock_critico:this.producto.stock_critico,precio:this.producto.precio,imagen:urll,estado:this.producto.estado}
                console.log(datosEnviar);
                let url = 'http://localhost/test/?insertar=1';
                axios.post(url,datosEnviar)
                .then((datosRespuesta=>{
                    if(datosRespuesta.data.success===1){
                        // window.location.href='ListProducts'
                        console.log('listo');
                    }else{
                        console.log('Error');
                        this.error = true;
                    }
                }))
            }
        },
        Test(event, num){
            if(num==1){
                this.sw = 1;
                this.ch = 2;
                this.handleFileChange(event);
                this.sw1 = 0;
                this.ch1 = 0;
            }else{
                this.sw1 = 1;
                this.ch1 = 2;
                this.sw = 0;
                this.ch = 0;
                this.handleFileChange1(event);
            }
        },
        handleFileChange: function(event) {
            console.log("handlefilechange", event.target.files);
            this.file = event.target.files[0];
            this.filesSelected = event.target.files.length;
            this.subir();
        },
        handleFileChange1: function(event) {
            console.log("handlefilechange1", event.target.files);
            this.file = event.target.files[0];
            this.filesSelected = event.target.files.length;
            this.subir();
        },
        prepareFormData: function() {
            var preset = 'vue-upload';
            this.formData = new FormData();
            this.formData.append("upload_preset", preset);
            this.formData.append("tags", this.tags); 
            this.formData.append("file", this.fileContents);
        },
        subir: function() {
            if(this.sw == 1 && this.ch == 2){
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
                    //PRIMER UPLOAD
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
            if(this.sw1 == 1 && this.ch1 == 2){
            console.log("upload1", this.file.name);
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
                    urlV = this.results.url;
                    //SEGUNDO UPLOAD
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
        },
    }
}
</script>