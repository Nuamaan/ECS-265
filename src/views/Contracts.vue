<template>
  <div class="contracts">
    <my-header></my-header>
    <div v-if="isDrizzleInitialized" id="app">
      <div class="pending center">
        <h2 class="contracts-heading">Pending Contracts</h2>
          <ul v-if="getPromise">
            <!-- {{ utils.toUtf8(promise) }} -->
            <li v-for="(promise, i) in getPromise" v-bind:key="i">{{ utils.toUtf8(promise) }}</li>
          </ul>
      </div>
      <div class="signed center">
        <h2 class="contracts-heading">Signed Contracts</h2>
      </div>
      <div class="rejected center">
        <h2 class="contracts-heading">Rejected Contracts</h2>
      </div>
    </div>
    <div class="center-screen" v-else>
      Detecting Metamask...
    </div>
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'
import { mapGetters } from "vuex";
export default {
  name: 'contracts',
  data () {
    return {
  
    }
  },
  computed: {
    // Use mapGetters to bring in needed methods from the Drizzle plugin
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    ...mapGetters("contracts", ["getContractData"]),
    
    getPromise() {
      let data = this.getContractData({
        contract: "Promise",
        method: "viewPromise"
      });
      if (data === "loading") return false;
      return data;
    },
    
    // Utilities needed to transform bytes to strings
    utils() {
      return this.drizzleInstance.web3.utils;
    }
  },
  // Register smart contract before the component mounts to ensure data is available
  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "Promise",
      method: "viewPromise",
      methodArgs: []
    });
  },
  components: { MyHeader, MyFooter }
}
</script>

<style scoped>
.contracts-heading {
  text-align: left;
  display: inline;
}
.pending {
  text-align: center;
}
</style>