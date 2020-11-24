<template>
  <div class="create">
    <my-header></my-header>
    <main class="center">
      <div v-if="isDrizzleInitialized" id="app">
        <h1>Start Creating</h1>
        <div class="center">
          <div class="form">
            <drizzle-contract-form
              contractName="Promise"
              method="addPromise"
              :placeholders="['Your Public Key','Recipients Public Key','Your contract content...']"
            />
          </div>
        </div>
      </div>
      <div v-else>
        Loading application...
      </div>
      <!-- <h1>Start Creating</h1>
      <form action="">
        <div class="form-group">
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="1" placeholder="Recipient(s): Alice's Public Key"></textarea>
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="1" placeholder="Contract Title"></textarea>
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" placeholder="Write your contract here..."></textarea>
        </div>
      </form> -->
    </main>
      <!-- <p>Want to share your contract?</p> -->
      <div class="center">
        <button type="button" class="btn btn-light btn-lg" v-on:click="showConfirmation">Send &amp; Sign Message</button>
      </div>
      <div class="center">
        <!-- <h2>Pending Contracts</h2> Supposed to list pending contracts -->
        <ul v-if="getPromise">
          <!-- {{ utils.toUtf8(promise) }} -->
          <li v-for="(promise, i) in getPromise" :key="i">{{ utils.toUtf8(promise) }}</li>
        </ul>
      </div>
      <div class="center">
        <h3>Account</h3>
          <drizzle-account units="Ether" :precision="2" />
      </div>
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'
import { mapGetters } from "vuex";
import Contracts from './Contracts.vue';

export default {
  // name: 'imain',
  name: 'create',
  data () {
    return {
  
    }
  },
  computed: {
    // Use mapGetters to bring in needed methods from the Drizzle plugin
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    ...mapGetters("contracts", ["getContractData"]),

    getPromise() {
      this.getContractData({
        contract: "Promise",
        method: "viewPromise"
      });
    },

    // Utilities needed to transform bytes to strings
    utils() {
      return this.drizzleInstance.web3.utils;
    }
  },
  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "Promise",
      method: "addPromise",
      methodArgs: []
    });
  },
  methods: {
    showConfirmation() {
      this.$router.push({name: 'Confirmation'});
    }
  },
  components: { MyHeader, MyFooter, Contracts }
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

textarea{
  background-color:#d7dce2;
  border: #7d7e7e solid;
  border-width: 2px;
  margin-bottom: 10px;
}

p{
  padding-left: 395px;
}

img
{
  background: none;
}

h2, h3
{
  padding-top: 10px;
}

/* #app > form > button { */
/* #app > drizzle-contract-form > button
{
  font-size: 1.2em;
  color: #2c3e50;
  margin-left: 16px;
  border: none;
} */

</style>