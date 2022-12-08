<template>
<div id="app">
    <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="errorRut">
        Error, el rut no es valido...
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    Generar Venta
    <div class="card-body" style="text-align: left">
            <form v-on:submit.prevent="submit" >
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
                    <a href="#" id="add_new_field" @click="add"><i class="fa fa-plus"></i>Agregar otro producto</a><br>
                    <a href="#" id="add_new_field" @click="minus" v-if="count>1"  ><i class="fa fa-plus"></i>Quitar un producto</a>
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-label">RUT: </label>
                    <input type="text"
                        class="form-control" required name="nombre" minlength="8" maxlength="9"  id="nombre" v-model="rut" aria-describedby="helpId" placeholder="RUT">
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
                <div class="mb-3" v-if="EstadoSeleccionado.nombre == 'Pendiente'">
                    <label for="SaldoPendiente" class="form-label">Abono: </label>
                    <input type="number"
                        class="form-control" required name="SaldoPendiente" min="1" max="9999999"  id="SaldoPendiente" v-model="abono" aria-describedby="helpId" >
                    <small id="helpId" class="form-text text-muted">Ingresa el abono que dará el cliente</small>
                </div>
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success">Generar Venta</button>
                    <router-link :to="{name:'ListProducts'}" class="btn btn-warning">Cancelar </router-link>
                </div>
            </form>
        </div>
</div>
<div class="modal fade" id="Precio" tabindex="-1" aria-labelledby="PrecioLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Precio</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                el total de esta venta es de: ${{total}}
            </div>
            <div class="modal-body" v-if="abonoS == true">
                Lo que debe el cliente es:  ${{descuento}}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="Refrescar()">Cerrar</button>
            </div>
        </div>
    </div>
</div>
<button  id="btnOpen" hidden  data-bs-toggle="modal" data-bs-target="#Precio"></button>
<div class="modal fade" id="Abono" tabindex="-1" aria-labelledby="AbonoLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Precio Restante</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="Refrescar()">Cerrar</button>
            </div>
        </div>
    </div>
</div>
<button  id="btnOpen1" hidden  data-bs-toggle="modal" data-bs-target="#Abono"></button>
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
            abono:0,
            total:0,
            descuento:0,
            abonoS: false,
            errorRut: false,
        }
    },
    methods:{
        add(){
            this.count ++;
        },
        minus(){
            this.count --;
        },
        submit(){
            var rutV = this.ValidarRut(this.rut);
                if(rutV == 'error2'){
                    this.errorRut =true;
                }else{
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
                            console.log(datosRespuesta.data);
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
                    this.total = precios;
                    console.log(datosEnviar);
                    axios.post(url,datosEnviar).then((datosRespuesta=>{
                        if(datosRespuesta.data.success===1){
                            console.log('LISTO')
                            this.clickButton();
                        }
                    }))
                    this.descuento = this.total - this.abono;
                    if(this.EstadoSeleccionado.nombre == "Pendiente"){
                        url = "http://localhost/test/?insertarDeuda=1";
                        datosEnviar = {rut: this.rut,deuda:this.descuento};
                        axios.post(url,datosEnviar).then((datosRespuesta=>{
                            console.log(datosRespuesta.data);
                        }))
                        this.abonoS = true;
                    }
                
                
            }
        },
        clickButton() {
            var click_event = new CustomEvent('click');
            var btn_element = document.querySelector('#btnOpen');
            btn_element.dispatchEvent(click_event);
        },
        clickButton1() {
            var click_event = new CustomEvent('click');
            var btn_element = document.querySelector('#btnOpen1');
            btn_element.dispatchEvent(click_event);
        },
        Refrescar(){
            window.location.href='/admin'
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