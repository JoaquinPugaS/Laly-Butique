import { createApp } from 'vue'
import App from './views/AdminView.vue'
// import App from './HomePeople.vue'
import router from './router'

createApp(App).use(router).use(router).mount('#app')
