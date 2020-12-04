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
            <!--
            <drizzle-contract-form
            contractName="Promise"
            method='signPromise'
            :placeholders="[]"
            /> -->
            <!-- :placeholders="[]" -->
            <!-- :methodArgs="[i]" -->
            <!-- <a href="#" @click="signPromise(i)">Sign</a> -->
            <!--<button type="button" class="btn btn-light btn-lg" v-on:click="signPromise(i)">Sign</button> }}-->
            <!-- <button type="button" class="btn btn-light btn-lg" v-on:click="rejectPromise">Reject</button> -->
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
      if (data === "loading") return false;
      return data;
    },
/*
    signPromise(idx) {
      console.log("contract ID: ", idx)
      this.created
      this.getContractData({
        contract: "Promise",
        method: "signPromise",
        methodArgs: [idx]
      })
    },*/
    
   // rejectPromise(){
   //   
   // },

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