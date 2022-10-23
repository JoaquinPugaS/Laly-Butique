import { createApp } from 'vue'
// import App from './views/HomePeople.vue'
// import App from './views/AdminView.vue'
import router from './router'
import App from './App.vue'

createApp(App).use(router).use(router).mount('#app')
// const app = createApp(App)