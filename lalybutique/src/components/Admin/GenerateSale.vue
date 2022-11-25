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
                    <button type="submit" class="btn btn-success" @click="submit()">Generar Venta</button>
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
import axios from 'axios';
var precio = 0;
export default {
    data(){
        return{
            count: 1,
            values: [],
            ar: [],
            rut: '',
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
                if(key.includes('id')){
                    this.id = this.values[key];
                }
                if(key.includes('cant')){
                    this.cant = this.values[key];
                }
                if(i % 2 ==0){
                    this.ar.push({id: this.id, cant: this.cant});
                }
            }
            let id = Math.floor((Math.random() * 1000000) + 1);
            let url = "http://localhost/test/?ventaM=1";
            var asd = 0;
            var o = 0;
            for(var j in this.ar){
                var datosEnviar = {producto_id: this.ar[j].id, cantidad:this.ar[j].cant,codigo:id};
                axios.post(url,datosEnviar).then((datosRespuesta=>{
                    asd=(datosRespuesta.data.precio_unitario * datosRespuesta.data.cantidad);
                    o++;
                    precio = precio +asd;
                    if(o == this.ar.length){
                        console.log('LARGO ARRAY: '+this.ar.length + ' O: '+o);
                        console.log('MANDANDO');
                        this.addPrice(precio,1,id);
                    }else{
                        console.log('LARGO ARRAY: '+this.ar.length + ' O: '+o);
                        this.addPrice(precio,0,id);
                    }
                }
                ))
            }
        },
        addPrice(precios,num,id){
            precio = precios
            if(num == 1){
                precio = precios
                console.log('precios en el añadir'+precios);
                if(this.EstadoSeleccionado.nombre === 'Seleccione uno'){
                    this.EstadoSeleccionado.nombre = 'Pagado'
                }
                var url = "http://localhost/test/?venta=1";
                let date = new Date().toLocaleDateString();
                var datosEnviar={rut: this.rut, total: precios, estado: this.EstadoSeleccionado.nombre, fecha:date, codseg: 'No tiene', id_venta: id};
                console.log(datosEnviar);
                axios.post(url,datosEnviar).then((datosRespuesta=>{
                    if(datosRespuesta.data.success===1){
                        console.log('LISTO')
                    }
                }))
            }
        }   
        
    }
}
</script>