<template>
  <div class="contracts">
    <my-header></my-header>
    <div v-if="isDrizzleInitialized" id="app">
      <div class="pending center">
        <h2 class="contracts-heading">Pending Contracts</h2>
          <ul v-if="getPromise">
            <!-- {{ utils.toUtf8(promise) }} -->
            <div style="text-align: left;" v-for="(promise, i) in getPromise" :key="i">
              {{i+1}}. {{ utils.toUtf8(promise)}} <br />
            </div>
          </ul>
          <ul v-else> Oh no... </ul>
      </div>
      <div class="signed center">
        <drizzle-contract-form
          contractName="Promise"
          method='signPromise'
          :placeholders="[]" 
        />
      </div>
      <div class="signed center">
        <h2 class="contracts-heading">Signed Contracts</h2>
          <ul v-if="getSignedPromises">
            <div style="text-align: left;" v-for="(promise, i) in getSignedPromises" :key="i">
              {{i+1}}. {{ utils.toUtf8(promise)}} <br />
            </div>
          </ul>
          <ul v-else> Oh no... </ul>
      </div>
      <div class="rejected center">
        <h2 class="contracts-heading">Rejected Contracts</h2>

      </div>
    </div>
    <div v-else>
      Loading application...
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

  signedPromises () {
    return {

    }
  },
  
  methods : {
    print: function(idx){
      console.log("contract ID: " + idx);
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
      if (data === "loading"){
        console.log("loading...")
        return false;
      }
      return data;
    },

    getSignedPromises() {
      let signedPromises = this.getContractData({
        contract: "Promise",
        method: "viewConfirmed"
      });
      if (signedPromises === "loading"){
        console.log("loading...")
        return false;
      }
      return signedPromises;
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
    
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "Promise",
      method: "viewConfirmed",
      methodArgs: []
    });
  },
  components: { MyHeader, MyFooter }
  // created: function() {
  //   axios.get('/static/products.json')
  //   .then((response) =>{
  //     this.products=response.data.products;
  //     console.log(this.products);
  //   });
  // }
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