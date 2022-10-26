import { createStore } from 'vuex'

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
        }
    },
    actions:{

    },
    modules:{

    }
})