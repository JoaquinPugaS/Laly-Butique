<template>
    <div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						<div class="preview-pic tab-content">
                            <img v-bind:src="`${producto.imagen}`" class="card-img-top" alt="..." width="200" height="400" v-if="producto.imagen!= ''">
                            <img v-else src="../assets/noDisp.png" width="250" height="200" style="margin-rigth: 20px;margin-left: 20px"  >
                            <!-- <div class="tab-pane active" id="pic-1"><img src="http://placekitten.com/400/252" /></div> -->
                            <img v-bind:src="`${variantes.imagen}`" class="card-img-top" alt="..." width="200" height="400" v-if="variantes.imagen != ''">

						</div>
						<ul class="preview-thumbnail nav nav-tabs">
                            <!-- <li class="active"><a data-target="#pic-1" data-toggle="tab"><img v-bind:src="`${variantes.imagen}`"  /></a></li> -->

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
						<h4 class="price">Precio: <span>${{producto.precio}}</span></h4>
                        <div v-if="variantes.length != 0 ">
                            <h6 class="text-uppercase">Variaciones</h6> 
                            <div class="sizes mt-5">
                                <label class="radio"> <input type="radio" name="size" value="{{variantes.nombre}}" checked> <span>{{variantes.nombre}}</span> </label> 
                            </div>
                        </div>
                        <!-- <div class="sizes mt-5">
                            <h6 class="text-uppercase">Size</h6> <label class="radio"> <input type="radio" name="size" value="S" checked> <span>S</span> </label> <label class="radio"> <input type="radio" name="size" value="M"> <span>M</span> </label> <label class="radio"> <input type="radio" name="size" value="L"> <span>L</span> </label> <label class="radio"> <input type="radio" name="size" value="XL"> <span>XL</span> </label> <label class="radio"> <input type="radio" name="size" value="XXL"> <span>XXL</span> </label>
                        </div> -->
						<div class="action">
							<button type="button" class="btn btn-primary" @click="addtoCart();">Agregar al carrito</button>
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
            variantes:{},
        }
    },
    created:function(){
        this.obtenerInformacionID();
    },
    methods:{
            obtenerInformacionID(){
                fetch('http://localhost/test/?consultar='+this.$route.params.id)
                .then(respuesta=>respuesta.json())
                .then((datosRespuesta)=>{
                    console.log(datosRespuesta.variante.length)
                    this.producto=datosRespuesta.producto[0];
                    this.variantes=datosRespuesta.variante[0];
            })
        },

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