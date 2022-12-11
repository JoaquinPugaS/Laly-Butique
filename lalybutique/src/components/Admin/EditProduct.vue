<template>
    <div class="container">
    <div class="card">
        <div class="card-header">
            Editar Productos
        </div>
        <div class="card-body" style="text-align: left">
            <form v-on:submit.prevent="upload" >
                <div class="alert alter-danger" role="alert" v-if="error">
                        Error, El nombre del producto ya existe en la base de datos
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre: </label>
                    <input type="text"
                        class="form-control" required name="nombre" minlength="1" maxlength="50" v-model="producto.nombre" id="nombre" aria-describedby="helpId" placeholder="Nombre">
                    <small id="helpId" class="form-text text-muted">Ingresa el nombre del producto</small>
                </div>
                <div class="mb-3">
                    <label for="tipo" class="form-label">Tipo: </label> <br>
                    <Listbox v-model="TipoSeleccionado">
                        <ListboxButton>{{TipoSeleccionado.nombre}}</ListboxButton>
                        <ListboxOptions>
                            <ListboxOption v-for="tipo in tipos" :key="tipo.id" :value="tipo">
                                {{tipo.nombre}}
                            </ListboxOption>
                        </ListboxOptions>
                    </Listbox>
                    <br>
                    <small id="helpId" class="form-text text-muted">Ingresa el tipo de producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock" class="form-label">Stock: </label>
                    <input type="number"
                        class="form-control" required name="stock" min="1" max="9999" v-model="producto.stock" id="stock" aria-describedby="helpId" placeholder="Stock">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock del producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock_critico" class="form-label">Stock Critico: </label>
                    <input type="number"
                        class="form-control" required name="stock_critico" min="1" max="99" v-model="producto.stock_critico" id="stock_critico" aria-describedby="helpId" placeholder="Stock critico">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock critico del producto</small>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio: </label>
                    <input type="number"
                        class="form-control" required name="precio" min="1" max="999999999" v-model="producto.precio" id="precio" aria-describedby="helpId" placeholder="Precio">
                    <small id="helpId" class="form-text text-muted">Ingresa el Precio del producto</small>
                </div>
                <div class="mb-3">
                    <label for="talla" class="form-label">Talla: </label> <br>
                    <Listbox v-model="TallaSeleccionada">
                        <ListboxButton>{{TallaSeleccionada.nombre}}</ListboxButton>
                        <ListboxOptions>
                            <ListboxOption v-for="talla in Tallas" :key="talla.id" :value="talla">
                                {{talla.nombre}}
                            </ListboxOption>
                        </ListboxOptions>
                    </Listbox>
                    <br>
                    <small id="helpId" class="form-text text-muted">Ingresa la talla de producto</small>
                </div>
                <div class="mb-3" id="uploadImage">
                    <label for="imagen" class="form-label">Imagen: </label>
                    <input type="file"
                        class="form-control"  name="imagen" id="file-input" aria-describedby="helpId" placeholder="imagen" accept="image/png, image/jpeg, image/jpg" @change="handleFileChange($event)">
                </div>
                <div class="fixed top-16 w-72">
                    <label for="estado" class="form-label">Estado: </label>
                    <Listbox v-model="EstadoSeleccionado">
                        <div class="relative mt-1">
                        <ListboxButton 
                        >
                            <span class="block truncate">{{ EstadoSeleccionado.nombre }}</span>
                            <span>
                                <ChevronUpDownIcon style="width:30px" aria-hidden="true"/>
                            </span>
                        </ListboxButton>
                        <transition
                        leave-active-class="transition duration-100 ease-in"
                        leave-from-class="opacity-100"
                        leave-to-class="opacity-0"
                        >
                        <ListboxOptions class="absolute mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm">
                            <ListboxOption 
                            v-for="estado in estados"
                            :key="estado.id" 
                            :value="estado" 
                            :disabled="estado.nodisponible"
                            v-slot="{active, selected}"
                            as="ListBox"
                            >
                            <li :class="[active ? 'bg-amber-100 text-amber-900' : 'text-gray-900','relative cursor-default select-none py-2 pl-10 pr-4',]">
                                <span
                                :class="[selected ? 'font-small' : 'font-normal','block truncate',]">
                                {{estado.nombre}}</span>
                            </li>
                            </ListboxOption>
                        </ListboxOptions>
                        </transition>
                        </div>
                    </Listbox><br>
                    <small id="helpId" class="form-text text-muted">Ingresa el Estado del producto</small>
                </div>
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success">Modificar</button>
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
import {ChevronUpDownIcon} from '@heroicons/vue/20/solid'
const estados= [
    {id: 1, nombre: 'Disponible', nodisponible: false},
    {id: 2, nombre: 'No disponible', nodisponible: false},
    {id: 3, nombre: 'Agotado', nodisponible: false},
]
const Tallas= [
    {id: 1, nombre: 'XS', nodisponible: false},
    {id: 2, nombre: 'S', nodisponible: false},
    {id: 3, nombre: 'M', nodisponible: false},
    {id: 4, nombre: 'L', nodisponible: false},
    {id: 5, nombre: 'XL', nodisponible: false},
    {id: 6, nombre: 'XXL', nodisponible: false},
]
const estadoTallas=[
    {id: 0, nombre: 'Seleccione uno', nodisponible: false},
]
const estadoD=[
    {id: 0, nombre: 'Seleccione uno', nodisponible: false},
]
const estadoT=[
    {id: 0, nombre: 'Seleccione uno', nodisponible: false},
]
const EstadoSeleccionado = ref(estadoD[0])
var TipoSeleccionado = ref(estadoT[0])
var TallaSeleccionada = ref(estadoTallas[0])

</script>
<script>
var urll = " ";
import axios from "axios";
export default {
    components: {ChevronUpDownIcon},

    data(){
        return{
            producto:{},
            tipos:{},
            error:false,
        }

    },
    beforeMount(){
    if(!localStorage.getItem('admin_token')){
        window.location.href='/Login'
    }
    },
    created:function(){
        this.obtenerInformacionID();
    },
    methods:{
        obtenerInformacionID(){
            let url = 'http://localhost/test/?consultar='+this.$route.params.id;
            axios.get(url)
            .then((datosRespuesta)=>{
                this.producto=datosRespuesta.data[0][1];
                this.EstadoSeleccionado.nombre = this.producto.estado
                this.TipoSeleccionado.nombre = this.producto.nombre_tipo
                this.TipoSeleccionado.id = this.producto.id_tipo
                this.TallaSeleccionada.nombre = this.producto.talla
        })
        url = 'http://localhost/test/?Tipos';
            axios.get(url).then((datosRespuesta =>{
                this.tipos = datosRespuesta.data;
            }))
    },
    ModificarProducto(urla){
        this.urll = urla;
        console.log('link',urll)
        this.producto.estado = this.EstadoSeleccionado.nombre
        this.producto.tipo = this.TipoSeleccionado.id
        this.producto.talla = this.TallaSeleccionada.nombre
        console.log(this.TipoSeleccionado)
        var datosEnviar={id:this.$route.params.id,nombre:this.producto.nombre,tipo:this.producto.tipo,stock:this.producto.stock,stock_critico:this.producto.stock_critico,precio:this.producto.precio,talla:this.producto.talla,imagen:this.urll,estado:this.producto.estado}
        let url = 'http://localhost/test/?modificar='+this.$route.params.id;
        axios.post(url,datosEnviar)
        .then((datosRespuesta=>{
            if(datosRespuesta.data.success==1){
                window.location.href='../ListProducts'
            }else{
                this.error = true;
            }
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
            if(this.file){
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
            }else{
                this.ModificarProducto(this.producto.imagen);
            }
        }
    }
}
</script>