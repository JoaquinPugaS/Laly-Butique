<template>
    <div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						
						<div class="preview-pic tab-content">
                            <img v-bind:src="`${producto.imagen}`" class="card-img-top" alt="..." width="200" height="200" v-if="producto.imagen!= ' '">
                            <img v-else src="../assets/noDisp.png" width="250" height="200" style="margin-rigth: 20px;margin-left: 20px" >
                            <!-- <div class="tab-pane active" id="pic-1"><img src="http://placekitten.com/400/252" /></div>
                            <div class="tab-pane" id="pic-2"><img src="http://placekitten.com/400/252" /></div>
                            <div class="tab-pane" id="pic-3"><img src="http://placekitten.com/400/252" /></div>
                            <div class="tab-pane" id="pic-4"><img src="http://placekitten.com/400/252" /></div>
                            <div class="tab-pane" id="pic-5"><img src="http://placekitten.com/400/252" /></div> -->
						</div>
						<ul class="preview-thumbnail nav nav-tabs">
                            <!-- <li class="active"><a data-target="#pic-1" data-toggle="tab"><img src="http://placekitten.com/200/126" /></a></li>
                            <li><a data-target="#pic-2" data-toggle="tab"><img src="http://placekitten.com/200/126" /></a></li>
                            <li><a data-target="#pic-3" data-toggle="tab"><img src="http://placekitten.com/200/126" /></a></li>
                            <li><a data-target="#pic-4" data-toggle="tab"><img src="http://placekitten.com/200/126" /></a></li>
                            <li><a data-target="#pic-5" data-toggle="tab"><img src="http://placekitten.com/200/126" /></a></li> -->
						</ul>
					</div>
					<div class="details col-md-6">
						<h3 class="product-title">{{producto.nombre}}</h3>
						<div class="rating">
							<div class="stars">
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star"></span>
								<span class="fa fa-star"></span>
							</div>
						</div>
						<!-- <p class="product-description">Suspendisse quos? Tempus cras iure temporibus? Eu laudantium cubilia sem sem! Repudiandae et! Massa senectus enim minim sociosqu delectus posuere.</p> -->
						<h4 class="price">Precio: <span>{{producto.precio}}</span></h4>
                        <div class="sizes mt-5">
                            <h6 class="text-uppercase">Size</h6> <label class="radio"> <input type="radio" name="size" value="S" checked> <span>S</span> </label> <label class="radio"> <input type="radio" name="size" value="M"> <span>M</span> </label> <label class="radio"> <input type="radio" name="size" value="L"> <span>L</span> </label> <label class="radio"> <input type="radio" name="size" value="XL"> <span>XL</span> </label> <label class="radio"> <input type="radio" name="size" value="XXL"> <span>XXL</span> </label>
                        </div>
                        <div class="sizes mt-5">
                            <h6 class="text-uppercase">Colores</h6> <label class="radio"> <input type="radio" name="size" value="ROJO" checked> <span>ROJO</span> </label> <label class="radio"> <input type="radio" name="size" value="AZUL"> <span>AZUL</span> </label> <label class="radio"> <input type="radio" name="size" value="AMARILLO"> <span>AMARILLO</span> </label>
                        </div>
						<div class="action">
							<button type="button" class="btn btn-primary" @click="addtoCart()">Agregar al carrito</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
export default {
    data(){
        return{
            producto:{},
            // carrito:[],
        }
    },
    created:function(){
        this.obtenerInformacionID();
    },
    // eslint-disable-next-line
    // props: ['producto'],
    methods:{
            obtenerInformacionID(){
                fetch('http://localhost/test/?consultar='+this.$route.params.id)
                .then(respuesta=>respuesta.json())
                .then((datosRespuesta)=>{
                    this.producto=datosRespuesta[0];
            })
        },
        // AgregarAlCarrito(producto) {
        //     const itemCart = this.carrito.filter((item) => item.id == producto.id)[0]; 
        //     if(itemCart != undefined){
        //         itemCart.cantidad++;
        //     }else{
        //         const itemCart = {
        //             id: producto.id,
        //             nombre: producto.nombre,
        //             precio: producto.precio,
        //             cantidad: 1
        //         };
        //         this.carrito.push(itemCart);
        //     }
        //     console.log(this.carrito);
        // },
        addtoCart(){
            this.$store.commit('addtoCart',this.producto)
        }
    },
    computed:{
        product_total(){
            return this.$store.getters.productQuantity(this.producto)
        }
    }
}
</script>