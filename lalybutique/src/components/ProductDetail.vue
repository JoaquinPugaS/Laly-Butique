<template>
    <div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						<div class="preview-pic tab-content">
                            <img v-bind:src="`${producto.imagen}`" class="card-img-top" alt="..." width="200" height="400" v-if="producto.imagen!= ' '">
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
                        <h5>id: {{producto.id}}</h5>
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
                        <div v-if="variant == true ">
                            <h6 class="text-uppercase">Variaciones</h6> 
                            <div class="sizes mt-5" v-for="variante in variantes" :key="variante.id">
                                <h5>{{variante.descripcion}}</h5>
                                    
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
    <div class="alert alert-success d-flex align-items-center" role="alert" v-if="alert==true" style="text-align:right">
        <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
        <div>
            Producto agregado satisfactoriamente
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

	</div>
    <!-- <v-alert type="success" v-if="alert==true"></v-alert> -->
</template>
<script>
import axios from 'axios'
export default {
    data(){
        return{
            producto:{},
            variantes:{},
            variant: false,
            alert: false,
        }
    },
    beforeMount(){
        this.obtenerInformacionID();
    },
    methods:{
            obtenerInformacionID(){
                let url = 'http://localhost/test/?consultar='+this.$route.params.id;
                axios.get(url)
                .then((datosRespuesta)=>{
                    this.producto=datosRespuesta.data[0][1]
                    console.log(datosRespuesta.data);
                    if(datosRespuesta.data[1].length > 1){
                        this.variantes=datosRespuesta.data[1][1];
                        this.variant = true;
                    }
            })
        },

        addtoCart(){
            this.$store.commit('addtoCart',this.producto)
            this.alert = true
        }
    },
    computed:{
        product_total(){
            return this.$store.getters.productQuantity(this.producto)
        }
    }
}
</script>