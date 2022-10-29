<template>
    <div>
        <h1>Tu Carrito</h1>
        <div class="table-responsive">
            <table class="table table-primary">
                <thead>
                    <tr>
                        <th scope="col">NOMBRE </th>
                        <th scope="col">PRECIO </th>
                        <th scope="col">CANTIDAD </th>
                        <th scope="col">Total Producto </th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="producto in productos" :key="producto.id">
                        <td>{{producto.nombre}}</td>
                        <td>${{producto.precio}}</td>
                        <td>{{producto.cantidad}}</td>
                        <td>${{producto.precio * producto.cantidad}}</td>
                        <td><a name="" id="" class="btn btn-primary" @click="eliminarCarro(producto)" role="button">Eliminar</a></td>
                        <td><a name="" id="" class="btn btn-primary" @click="addtoCart(producto)" role="button">Agregar</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
            <h1>Total: ${{ cart_total }}</h1>
            <router-link :to="{ name: 'Checkout'}" class="btn btn-success">Checkout</router-link>

    </div>
</template>
<script>
export default {
    data(){
        return{
            total: 0
        }
    },
    methods:{
        eliminarCarro(producto){
            this.$store.commit('removeFromCart',producto)
        },
        addtoCart(producto){
            this.$store.commit('addtoCart',producto)
        }
    }
    ,computed:{
        productos(){
            return this.$store.getters.cartItems
        },
        item_cost(){
            return this.producto.precio * this.producto.cantidad
        },
        cart_total(){
            return this.$store.getters.cartTotal
        },
    },
}
</script>