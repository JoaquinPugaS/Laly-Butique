<template>
<div id="app">
    Generar Venta
    <div class="card-body" style="text-align: left">
            <form v-on:submit.prevent="upload" >
                <div  v-for="key in count" :key="key">
                    <div class="mb-3">
                        <label for="stock" class="form-label">ID DEL PRODUCTO: </label>
                        <input type="number"
                            class="form-control" required name="stock" min="1" max="9999" v-model="values['id '+key]" :id="key" aria-describedby="helpId" placeholder="ID">
                        <small id="helpId" class="form-text text-muted">Ingresa el ID del producto a vender</small>
                    </div>
                    <div class="mb-3">
                        <label for="stock_critico" class="form-label">CANTIDAD PRODUCTO: </label>
                        <input type="number"
                            class="form-control" required name="stock_critico" min="1" max="99" v-model="values['cant '+key]" :key="key" aria-describedby="helpId" placeholder="Cant Producto">
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
    name: 'app',
    data(){
        return{
            count: 1,
            values: [],
            ar: [],
            prod: [],
            fd: 1,
            rut: '',
            id: 0,
            total1:0,
            cod:0,
        }
    },
    methods:{
        add(){
            this.count ++;
        },
        submit(){
            var i = 0;
            for (var key of Object.keys(this.values)) {
                i++;
                // console.log(key)
                if(key.includes('id')){
                    // console.log(this.values[key]);
                    this.id = this.values[key];
                }
                if(key.includes('cant')){
                    // console.log('CANT');
                    this.cant = this.values[key];
                }
                if(i % 2 ==0){
                    // console.log(this.id + ' '+ this.cant)
                    this.ar.push({id: this.id, cant: this.cant});
                }
                
            }
            let id = Math.floor((Math.random() * 1000000) + 1);
            let url = "http://localhost/test/?ventaM=1";
            var toti = 0;
            for(var j in this.ar){
                // console.log(this.ar[j].id + ' '+ this.ar[j].cant);
                var datosEnviar = {producto_id: this.ar[j].id, cantidad:this.ar[j].cant,codigo:id};
                axios.post(url,datosEnviar).then((datosRespuesta=>{
                    if(datosRespuesta.data.success===1){
                        console.log('inserto tabla pedido');
                        var total = (datosRespuesta.data.precio_unitario * datosRespuesta.data.cantidad);
                        // console.log(datosRespuesta.data.precio_unitario * datosRespuesta.data.cantidad);
                        this.cod = datosRespuesta.data.cod_venta;
                        toti = toti + total;
                    }
                })) 
            }
            this.addSale(toti,id);
        },
        addSale(toti,id){
            if(this.EstadoSeleccionado.nombre === 'Seleccione uno'){
                this.EstadoSeleccionado.nombre = 'Pagado'
            }
            this.total1 = toti
            var url = "http://localhost/test/?venta=1";
            let date = new Date().toLocaleDateString();
            var datosEnviar={rut: this.rut, total: this.total1, estado: this.EstadoSeleccionado.nombre, fecha:date, codseg: 'No tiene', id_venta: id};
            axios.post(url,datosEnviar).then((datosRespuesta=>{
                if(datosRespuesta.data.success===1){
                    console.log('LISTO')
                }
            }))
        }
        
    }
}
</script>