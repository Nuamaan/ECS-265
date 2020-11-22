<!-- <template>
 <metamask/>
</template><script> -->

<template>
  <div v-if="isDrizzleInitialized" id="app">
    <h1>Start Creating</h1>
    <drizzle-contract-form
      contractName="Promise"
      method="addPromise"
      :placeholders="[]"
    />
  </div>
  <div v-else>
    Loading application...
  </div>
</template>

<!--
<script>
import Metamask from '../components/Metamask'
import { mapGetters } from "vuex"
export default {
 name: 'test',
 computed: {
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),    
    ...mapGetters("contracts", ["getContractData"])
 },
 utils() {
      return this.drizzleInstance.web3.utils
    },
 beforeCreate () {
    console.log('registerWeb3 Action dispatched from Test.vue')
    this.$store.dispatch('registerWeb3')
  },
 components: {
 'metamask': Metamask
 }
}
</script>
-->

<script>
// Import mapGetters to allow easy access to the getters in Vuex as computed properties
import { mapGetters } from "vuex";

export default {
  computed: {
    // Use mapGetters to bring in needed methods from the Drizzle plugin
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    ...mapGetters("contracts", ["getContractData"]),

    // Utilities needed to transform bytes to strings
    utils() {
      return this.drizzleInstance.web3.utils;
    }
  },

  // Register smart contract before the component mounts to ensure data is available
  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "Promise",
      method: "addPromise",
      methodArgs: []
    });
  }
};
</script>

<style scoped>
</style>