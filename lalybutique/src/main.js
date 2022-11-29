import { createApp } from 'vue'
import router from './router'
import App from './App.vue'
import Store from './store'
import cors from 'cors'
// import vuetify from '@/plugins/vuetify'
createApp(App).use(router).use(Store).use(cors).mount('#app')
