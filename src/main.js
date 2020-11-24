import Vue from 'vue'
import App from './App.vue'
import router from './router'
require('./assets/app.css')
<<<<<<< Updated upstream
=======
// import { store } from './store'
// import store from './store' 
import Vuex from 'vuex'

import drizzleVuePlugin from "@drizzle/vue-plugin"
import drizzleOptions from "./drizzleOptions"
>>>>>>> Stashed changes

// Register Vuex
Vue.use(Vuex);

// Create and configure your Vuex Store
const store = new Vuex.Store({ state: {} });

Vue.config.productionTip = false
<<<<<<< Updated upstream
=======
// Register the drizzleVuePlugin
Vue.use(drizzleVuePlugin, { store, drizzleOptions })
>>>>>>> Stashed changes

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
