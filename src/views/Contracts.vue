<template>
  <div class="contracts">
    <my-header></my-header>
    <h1 class="center">My Contracts</h1><br>
    <div v-if="isDrizzleInitialized" id="app">
      <div class="pending center">
        <h2 class="contracts-heading">Pending Contracts</h2><br><br>
          <div v-if="getAllPendingPromises">

            <div class="contract-list" v-for="(pendingPromiseIndex, i) in getAllPendingPromiseIndices" v-bind:key="i">
              <h5 class="center">{{ getAllPendingPromiseTitles[i] }}</h5> 
              {{ getAllPendingPromises[i] }} <br><br>
              Creator: {{ getAllPendingPromiseBuilders[i] }}<br>
              Recipient: {{ getAllPendingPromiseRecipients[i] }}<br>
              <div class="center"><button v-if="isRecipient(getAllPendingPromiseRecipients[i])" class="sign-button" v-on:click="signPromise(pendingPromiseIndex)">Sign</button>
              <button v-if="isRecipient(getAllPendingPromiseRecipients[i])" class="reject-button" v-on:click="rejectPromise(pendingPromiseIndex)">Reject</button></div>
            </div>
          </div>
      </div>
      <div class="signed center">
        <h2 class="contracts-heading">Signed Contracts</h2><br><br>
            <div v-if="getAllSignedPromises">

              <div class="contract-list" v-for="(signedPromiseTitle, i) in getAllSignedPromiseTitles" v-bind:key="i">
                <h5 class="center">{{ getAllSignedPromiseTitles[i] }}</h5> 
                {{ getAllSignedPromises[i] }} <br><br>
                Creator: {{ getAllSignedPromiseBuilders[i] }}<br>
                Recipient: {{ getAllSignedPromiseRecipients[i] }}<br>
              </div>

          </div>
      </div>
      <div class="rejected center">
        <h2 class="contracts-heading">Rejected Contracts</h2><br><br> 
            <div v-if="getAllRejectedPromises">

              <div class="contract-list" v-for="(rejectedPromiseTitle, i) in getAllRejectedPromiseTitles" v-bind:key="i">
                <h5 class="center">{{ getAllRejectedPromiseTitles[i] }}</h5> 
                {{ getAllRejectedPromises[i] }} <br><br>
                Creator: {{ getAllRejectedPromiseBuilders[i] }}<br>
                Recipient: {{ getAllRejectedPromiseRecipients[i] }}<br>
              </div>

          </div>
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
import Web3 from 'web3';
var web3 = new Web3(Web3.givenProvider || 'ws://some.local-or-remote.node:9545');
export default {
  name: 'contracts',
  data () {
    return {
      account: '',
 
    }
  },
  computed: {
    // Use mapGetters to bring in needed methods from the Drizzle plugin
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    ...mapGetters("accounts", ["activeAccount", "activeBalance"]),
    ...mapGetters("contracts", ["getContractData"]),
    

    /***************Function for Pending Promises************************* */
    /**
     *  This function returns the list of pending promises for a single user.
     *  data contains an array of strings.
     *  @returns An array of strings that contain Promise details.
     */
    getAllPendingPromises() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllPendingPromises"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the titles of the pending promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllPendingPromiseTitles() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllPendingPromiseTitles"
      });
      if (data === "loading") return false;
      return data;
    },


    /**
     * This function returns the list of the creators of the pending promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllPendingPromiseBuilders() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllPendingPromiseBuilders"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the recipients of the pending promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllPendingPromiseRecipients() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllPendingPromiseRecipients"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the indices of the pending promises for a single user.
     * @returns An array of integers that contain Promise indices.
     */

    getAllPendingPromiseIndices() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllPendingPromiseIndices"
      });
      if (data === "loading") return false;
      return data;
    },

    /*************************End of Functions for Pending************************************************* */

    /**************************Functions for Signed Promises************************************************ */

    /**
     *  This function returns the list of signed promises for a single user.
     *  data contains an array of strings.
     *  @returns An array of strings that contain Promise details.
     */
    getAllSignedPromises() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllSignedPromises"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the titles of the signed promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllSignedPromiseTitles() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllSignedPromiseTitles"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the creators of the signed promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllSignedPromiseBuilders() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllSignedPromiseBuilders"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the recipients of the signed promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllSignedPromiseRecipients() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllSignedPromiseRecipients"
      });
      if (data === "loading") return false;
      return data;
    },
    /*************************End of Functions for Signed************************************************* */

    /*************************Start of Functions for Rejected********************************************* */
    
    /**
     *  This function returns the list of rejected promises for a single user.
     *  data contains an array of strings.
     *  @returns An array of strings that contain Promise details.
     */
    getAllRejectedPromises() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllRejectedPromises"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the titles of the rejected promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllRejectedPromiseTitles() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllRejectedPromiseTitles"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the creators of the rejected promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllRejectedPromiseBuilders() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllRejectedPromiseBuilders"
      });
      if (data === "loading") return false;
      return data;
    },

    /**
     * This function returns the list of the recipients of the rejected promises for a single user.
     * @returns An array of strings that contain Promise titles.
     */

    getAllRejectedPromiseRecipients() {
      let data = this.getContractData({
        contract: "SolidPromise",
        method: "viewAllRejectedPromiseRecipients"
      });
      if (data === "loading") return false;
      return data;
    },

    /*************************End of Functions for Rejected************************************************* */

    // Utilities needed to transform bytes to strings
    utils() {
      return this.drizzleInstance.web3.utils;
    }
  },
  // Register smart contract before the component mounts to ensure data is available
  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllPendingPromises",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllPendingPromiseTitles",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllPendingPromiseBuilders",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllPendingPromiseRecipients",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllSignedPromises",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllSignedPromiseTitles",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllSignedPromiseBuilders",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllSignedPromiseRecipients",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllRejectedPromises",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllRejectedPromiseTitles",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllRejectedPromiseBuilders",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllRejectedPromiseRecipients",
      methodArgs: []
    });

    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "SolidPromise",
      method: "viewAllPendingPromiseIndices",
      methodArgs: []
    }); 
    
    web3.eth.getAccounts().then(accounts => { 
      let account = accounts[0];
      this.account = account;
      });
    
  },
  methods: {
    signPromise(index) {
      this.drizzleInstance.contracts['SolidPromise'].methods['signPromise'].cacheSend(
        parseInt(index)
      )
    },
    rejectPromise(index) {
      this.drizzleInstance.contracts['SolidPromise'].methods['rejectPromise'].cacheSend(
        parseInt(index)
      )
    },
    isRecipient(recipient)
    {
      let recipientCheck = recipient.toString().substring(0, 42).toLowerCase() == this.account.toString().substring(0, 42).toLowerCase();
      return recipientCheck;
    }
    
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
  text-align: left;
}

.signed {
  text-align: left;
}

.rejected {
  text-align: left;
}

.promiseTitle {
  display: inline;
  margin-left: 10px;
  margin-top: 10px;
  float:right;
}

.contract-list {
  border:5px solid #b2d8d8;
  border-width: 25%;
  text-align: left;
  background-color: #F0F0F0;
  border-radius: 5px;
  margin-bottom: 10px;
  padding: 5px 10px 5px 10px;
}

.reject-button {
  background-color: darksalmon;
  border: 1px solid black;
  color: black;
  font-weight: bold;
}

.sign-button {
  background-color: darkseagreen;
  border: 1px solid black;
  color:black;
  font-weight: bold;
}
</style>