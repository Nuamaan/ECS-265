<!-- <template>
 <metamask/>
</template><script> -->

<template>
  <div class="create">
    <my-header></my-header>
    <main class="center">
      <div v-if="isDrizzleInitialized" id="app">
        <h1>Start Creating</h1>
        <drizzle-contract-form class="form-group"
          contractName="Promise"
          method="addPromise"
          :placeholders="['Creator\'s Public Key', 'Recipient(s): Alice\'s Public Key', 'Write your contract here...']"
        />
      </div>
      <div v-else>
        Loading application...
      </div>
    </main>
    <my-footer></my-footer>
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
//var inputBox = document.getElementsByTagName("input")[2];
//var textArea = document.createElement("textarea");
//inputBox.replaceWith(textArea);
//inputBox.parentNode.replaceChild(inputBox, textArea);
// Import mapGetters to allow easy access to the getters in Vuex as computed properties
import { mapGetters } from "vuex";
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'

export default {
  components: {MyHeader, MyFooter},
  methods: {
    createTextArea()
    {
      var thirdInputBox = document.getElementsByTagName("input")[2];
      


      var textAreaTag = document.createElement("textarea");
      var rowsAttribute  = document.createAttribute("rows");
      rowsAttribute.value = "5";
      var placeholderAttribute = document.createAttribute("placeholder");
      placeholderAttribute.value = "Write your contract here...";
      textAreaTag.setAttribute(rowsAttribute);
      textAreaTag.setAttribute(placeholderAttribute);

      thirdInputBox.replaceWith(textAreaTag);
    
    }

  },
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

    createTextArea();
  }
};
</script>

<style>
input{
  /* Bootstrap - class: form-control */
    display: block;
  width: 100%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;



  /* Custom from Create Page */
  background-color:#d7dce2;
  border: #7d7e7e solid;
  border-width: 2px;
  margin-bottom: 10px;

  /**  */
  height: 50px;

}

button{
  /* Bootstrap - class: btn */
    display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  content: "Send & Sign Message";

  /** btn-light btn-lg */
}


input:nth-of-type(3) {
  height: 100px;
  word-wrap: break-word;
        word-break: break-word;
}


form {
    word-wrap: break-word;
        word-break: break-word;
       overflow-wrap: break-word;

}


</style>
