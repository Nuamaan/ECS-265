<template>
  <div class="contracts">
    <my-header></my-header>
    <h1 class="center">My Contracts</h1><br>
    <div v-if="isDrizzleInitialized" id="app">
      <div class="pending center">
        <h2 class="contracts-heading">Pending Contracts</h2><br><br>
          <div v-if="getAllPendingPromises">

            <div class="contract-list" v-for="(pendingPromiseTitle, i) in getAllPendingPromiseTitles" v-bind:key="i">
              <h5>Title: {{ getAllPendingPromiseTitles[i] }}</h5>
              <h5>Terms:</h5> 
              {{ getAllPendingPromises[i] }} <br><br>
              Creator: {{ getAllPendingPromiseBuilders[i] }}<br>
              Recipient: {{ getAllPendingPromiseRecipients[i] }}<br>
              <div class="center"><button>Sign</button><button>Reject</button></div>
            </div>

          </div>
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
  border:1px solid black;
  border-width: 25%;
  text-align: left;
}
</style>