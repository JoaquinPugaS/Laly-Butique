<template>
    <div class="container">
    <div class="card">
        <div class="card-header">
            Productos
        </div>
        <div class="card-body">
            <form v-on:submit.prevent="AñadirProducto" >
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre: </label>
                    <input type="text"
                        class="form-control" name="nombre" v-model="producto.nombre" id="nombre" aria-describedby="helpId" placeholder="Nombre">
                    <small id="helpId" class="form-text text-muted">Ingresa el nombre del producto</small>
                </div>
                <div class="mb-3">
                    <label for="Stock" class="form-label">Stock: </label>
                    <input type="number"
                        class="form-control" name="Stock" v-model="producto.stock" id="Stock" aria-describedby="helpId" placeholder="Stock">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock del producto</small>
                </div>
                <div class="mb-3">
                    <label for="Stock_critico" class="form-label">Stock Critico: </label>
                    <input type="number"
                        class="form-control" name="Stock_critico" v-model="producto.stock_critico" id="Stock_critico" aria-describedby="helpId" placeholder="Stock critico">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock critico del producto</small>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio: </label>
                    <input type="number"
                        class="form-control" name="precio" v-model="producto.precio" id="precio" aria-describedby="helpId" placeholder="Precio">
                    <small id="helpId" class="form-text text-muted">Ingresa el Precio del producto</small>
                </div>
                <div class="mb-3">
                    <label for="imagen" class="form-label">imagen: </label>
                    <input type="text"
                        class="form-control" name="imagen" v-model="producto.imagen" id="imagen" aria-describedby="helpId" placeholder="imagen">
                    <small id="helpId" class="form-text text-muted">Ingresa la imagen del producto</small>
                </div>
                <div class="mb-3">
                    <label for="Estado" class="form-label">Estado: </label>
                    <input type="number"
                        class="form-control" name="Estado" v-model="producto.estado" id="Estado" aria-describedby="helpId" placeholder="Estado">
                    <small id="helpId" class="form-text text-muted">Ingresa el Estado del producto</small>
                </div>
                <div class="btn-group" role="group" aria-label="">
                    <button type="submit" class="btn btn-success">Añadir</button>
                    <button type="button" class="btn btn-warning">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
    </div>
</template>

<script>
export default {
    
    data(){
        return{
            producto:{}
        }
    },
    methods:{
        AñadirProducto(){
            console.log(this.producto);
        }
    }
}
</script>