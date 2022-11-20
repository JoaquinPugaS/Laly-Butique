<template>
<div id="app">
    Generar Venta
    <div class="card-body" style="text-align: left">
            <form v-on:submit.prevent="upload" >
                <div v-for="key in count" :key="key">
                    <div class="mb-3">
                        <label for="stock" class="form-label">ID DEL PRODUCTO: </label>
                        <input type="number"
                            class="form-control" required name="stock" min="1" max="9999" v-model="values['ID'+key]" :id="key" aria-describedby="helpId" placeholder="ID">
                        <small id="helpId" class="form-text text-muted">Ingresa el ID del producto a vender</small>
                    </div>
                    <div class="mb-3">
                        <label for="stock_critico" class="form-label">CANTIDAD PRODUCTO: </label>
                        <input type="number"
                            class="form-control" required name="stock_critico" min="1" max="99" v-model="values['CANT'+key]" :id="key"  aria-describedby="helpId" placeholder="Cant Producto">
                        <small id="helpId" class="form-text text-muted">Ingresa la cantidad del producto</small>
                    </div>
                </div>
                <div class="controls">
                    <a href="#" id="add_new_field" @click="add"><i class="fa fa-plus"></i>Agregar otro producto</a>
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-label">RUT: </label>
                    <input type="text"
                        class="form-control" required name="nombre" minlength="1" maxlength="50"  id="nombre" v-model="rut" aria-describedby="helpId" placeholder="RUT">
                    <small id="helpId" class="form-text text-muted">Ingresa el rut de la persona</small>
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
                    <small id="helpId" class="form-text text-muted">Ingresa el Estado de la venta</small>
                </div>
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success" @click="submit">Generar Venta</button>
                    <router-link :to="{name:'ListProducts'}" class="btn btn-warning">Cancelar </router-link>
                </div>
            </form>
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
    {id: 1, nombre: 'Pagado', nodisponible: false},
    {id: 2, nombre: 'Pendiente', nodisponible: false},
]
const estadoD=[
    {id: 0, nombre: 'Seleccione uno', nodisponible: false},

]
const EstadoSeleccionado = ref(estadoD[0])
</script>
<script>
import axios from 'axios'
export default {
    name: 'App',
    data: function(){
        return{
            count: 1,
            values: {},
            ar: [],
            prod: [],
            fd: 1,
            rut: '',
        }
    },
    methods:{
        add: function(){
            this.count++;
        },
        submit: function(){
            
            // for(var key of Object.keys(this.values)){
            //     // console.log(key + this.values[key]);
            //     console.log(key + this.values['ID'+[key]]);
            //     // this.ar= [key, this.values[key]]
            // }
            var preciototal = 0;
            var cont = 1;
            var i = 1
            for(i in this.values){
                if(cont % 2==0){
                    var cant = this.values[i]
                }else{
                    var id = this.values[i]
                }
                    var datosEnviar={idd: id, cantidad: cant}
                    this.ar.push(datosEnviar)
                // console.log(this.values[i])
                cont ++;
            }
            var j = 1
            let id1 = Math.floor((Math.random() * 1000000) + 1);
            var id_Venta = 0;
            for(j in this.ar){
                if(j % 2 != 0){
                    var idd = this.ar[j].idd
                    var ccant = this.ar[j].cantidad
                    datosEnviar = {producto_id: idd,cantidad:ccant,codigo:id1};
                    var url = "http://localhost/test/?ventaM=1";
                    axios.post(url,datosEnviar).then((datosRespuesta=>{
                        if(datosRespuesta.data.success===1){
                            console.log('guardo');
                            console.log(datosRespuesta.data.precio_unitario);
                            var precio_u = datosRespuesta.data.precio_unitario * ccant;
                            preciototal = preciototal + precio_u;
                            id_Venta = datosRespuesta.data.cod_venta;
                        }
                    // localStorage.setItem('cod_venta',datosRespuesta.data.cod_venta)
                    // window.location.href='Checkout'
                    }
                    ))
                }
            }
            var fecha = new Date().toLocaleDateString();
            if(this.EstadoSeleccionado.nombre === 'Seleccione uno'){
                this.EstadoSeleccionado.nombre = 'Pagado'
            }     
            url = "http://localhost/test/?venta=1";
            datosEnviar={rut: this.rut,total: preciototal,estado: this.EstadoSeleccionado.nombre, fecha: fecha, codseg: '',id_venta:id_Venta};
            axios.post(url,datosEnviar).then((datosRespuesta=>{
                if(datosRespuesta.data.success===1){
                    console.log('BIEN');
                }
            }))

            // console.log(this.ar)
            
        }
    }
}
</script>