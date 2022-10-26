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
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="producto in productos" :key="producto.id">
                        <td>{{producto.nombre}}</td>
                        <td>{{producto.precio}}</td>
                        <td>{{producto.quantity}}</td>
                        <td>{{producto.precio * producto.quantity}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
            <h1>Total: ${{ cart_total }}</h1>
    </div>
</template>
<script>
export default {
    data(){
        return{
            total: 0
        }
    }
    ,computed:{
        productos(){
            return this.$store.getters.cartItems
        },
        item_cost(){
            return this.producto.precio * this.producto.quantity
        },
        cart_total(){
            return this.$store.getters.cartTotal
        }
    },
}
</script>