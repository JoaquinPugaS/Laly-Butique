import { createStore} from 'vuex'

function updateLocalStorage(Cart){
    localStorage.setItem('Cart',JSON.stringify(Cart))
}

export default createStore({
    state:{
        Cart: []
    },
    getters:{
        productQuantity: state => product => {
            const item = state.Cart.find(i => i.id === product.id)
            if(item) return item.cantidad
            else return null
        },
        cartItems: state => {
            return state.Cart
        },
        cartItemsTotal: state => {
            return state.Cart.length
        },
        cartTotal: state => {
            return state.Cart.reduce((a, b) => a + (b.precio * b.cantidad),0)
        }

    },
    mutations:{
        addtoCart(state, product){
            let item = state.Cart.find(i => i.id === product.id)

            if(item){
                item.cantidad++
            }else{
                state.Cart.push({...product, cantidad: 1})
            }
            updateLocalStorage(state.Cart)
        },
        removeFromCart(state,product){
            let item = state.Cart.find(i => i.id === product.id)
            
            if(item){
                if(item.cantidad > 1){
                    item.cantidad--
                }else{
                    state.Cart = state.Cart.filter(i => i.id !== product.id)
                }
                updateLocalStorage(state.Cart)
            }
        },
        RemoveProduct(state,product){
            state.Cart = state.Cart.filter(i => i.id !== product.id)
            updateLocalStorage(state.Cart)
        },
        updateCartFromLocalStorage(state){
            const Cart = localStorage.getItem('Cart')
            if(Cart){
                state.Cart = JSON.parse(Cart)
                
            }
        },
        ClearCart(state){
            state.Cart = [];
            updateLocalStorage(state.Cart)
        }
    },
    actions:{

    },
    modules:{

    }
})