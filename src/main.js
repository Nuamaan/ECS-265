import Vue from 'vue'
import App from './App.vue'
import router from './router'
require('./assets/app.css')
import Vuex from 'vuex'

import drizzleVuePlugin from "@drizzle/vue-plugin"
import drizzleOptions from "./drizzleOptions"

// Register Vuex
Vue.use(Vuex);

// Create and configure your Vuex Store
const store = new Vuex.Store({ state: {} });

Vue.config.productionTip = false

// Register the drizzleVuePlugin
Vue.use(drizzleVuePlugin, { store, drizzleOptions })

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')