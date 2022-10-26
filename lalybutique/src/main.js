import { createApp } from 'vue'
import router from './router'
import App from './App.vue'
import Store from './store'
createApp(App).use(router).use(router).use(Store).mount('#app')
