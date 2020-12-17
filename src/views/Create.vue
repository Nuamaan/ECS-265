<template>
  <div class="create">
    <my-header></my-header>
    <main class="center">
      <div v-if="isDrizzleInitialized" id="app">
        <h1>Start Creating</h1>
        <drizzle-contract-form class="form-group"
          contractName="SolidPromise"
          method="addPromise"
          v-bind:placeholders="['Creator\'s Public Key', 'Recipient(s): Alice\'s Public Key', 'Contract Title', 'Write your contract here...']"
        />
      </div>
      <div v-else>
        Detecting Metamask...
      </div>
    </main>
    <my-footer></my-footer>
  </div>
</template>


<script>
// Import mapGetters to allow easy access to the getters in Vuex as computed properties
import { mapGetters } from "vuex";
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'
import Contracts from './Contracts.vue'

export default {
  components: {MyHeader, MyFooter},
  data() {
    return {
      
    }
  },
  methods: {
    createTextArea()
    {

    }

  },
  computed: {
    // Use mapGetters to bring in needed methods from the Drizzle plugin
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
  },
  mounted() {

  }
};
</script>

<style>
input {
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
  background-color:#efefef;
  margin-bottom: 10px;
  -moz-box-shadow: 0px 0px 15px #5c7789c1;
  -webkit-box-shadow: 0px 0px 15px #5c7789c1;
  box-shadow: 0px 0px 15px #5c7789c1;
  height: 50px;

}

button {
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
}

input:nth-of-type(3) {
  word-wrap: break-word;
  word-break: break-word;
}

form {
    word-wrap: break-word;
    word-break: break-word;
    overflow-wrap: break-word;
}
</style>
