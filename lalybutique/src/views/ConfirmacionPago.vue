<template>
<form method="post" action="Inserta aquí la url entregada">
    <input type="hidden" name="token_ws" value="Inserte aquí el token entregado" />
    <input type="submit" value="Ir a pagar" />
</form>
</template>
<script>

// import { WebpayPlus } from 'transbank-sdk'; // ES6 Modules
// import { Options, IntegrationApiKeys, Environment, IntegrationCommerceCodes } from 'transbank-sdk';
// const tx = new WebpayPlus.Transaction(new Options(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY, Environment.Integration))
// const response = await tx.create(buyorder, sessionId, this.cart_total(), returnUrl)
// console.log(response.url)
// console.log(response.token)
export default {
    methods:{
        Pagar(){
            }
    },        
    computed:{
            cart_total(){
                return this.$store.getters.cartTotal
        },
        }
}
</script>