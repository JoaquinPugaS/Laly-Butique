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
            if(item) return item.quantity
            else return null
        },
        cartItems: state => {
            return state.Cart
        },
        cartTotal: state => {
            return state.Cart.reduce((a, b) => a + (b.precio * b.quantity),0)
        }

    },
    mutations:{
        addtoCart(state, product){
            let item = state.Cart.find(i => i.id === product.id)

            if(item){
                item.quantity++
            }else{
                state.Cart.push({...product, quantity: 1})
            }
            updateLocalStorage(state.Cart)
        },
        removeFromCart(state,product){
            let item = state.Cart.find(i => i.id === product.id)

            if(item){
                if(item.quantity > 1){
                    item.quantity--
                }else{
                    state.Cart = state.Cart.filter(i => i.id !== product.id)
                }
                updateLocalStorage(state.Cart)
            }
        },
        updateCartFromLocalStorage(state){
            const Cart = localStorage.getItem('Cart')
            if(Cart){
                state.Cart = JSON.parse(Cart)
            }
        }
    },
    actions:{

    },
    modules:{

    }
})