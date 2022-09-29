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
                    <label for="stock" class="form-label">Stock: </label>
                    <input type="number"
                        class="form-control" name="stock" v-model="producto.stock" id="stock" aria-describedby="helpId" placeholder="Stock">
                    <small id="helpId" class="form-text text-muted">Ingresa el Stock del producto</small>
                </div>
                <div class="mb-3">
                    <label for="stock_critico" class="form-label">Stock Critico: </label>
                    <input type="number"
                        class="form-control" name="stock_critico" v-model="producto.stock_critico" id="stock_critico" aria-describedby="helpId" placeholder="Stock critico">
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
                    <label for="estado" class="form-label">Estado: </label>
                    <input type="number"
                        class="form-control" name="estado" v-model="producto.estado" id="estado" aria-describedby="helpId" placeholder="Estado">
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
        
        var datosEnviar={nombre:this.producto.nombre,stock:this.producto.stock,stock_critico:this.producto.stock_critico,precio:this.producto.precio,imagen:this.producto.imagen,estado:this.producto.estado}
        fetch('http://localhost/test/?insertar=1',{
            method:'POST',
            body:JSON.stringify(datosEnviar)
        })
        .then(respuesta=>respuesta.json())
        .then((datosRespuesta=>{
            console.log(datosRespuesta);
            window.location.href='read'
        }))
        }
    }
}
</script>