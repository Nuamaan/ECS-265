<template>
    <header>
        <div class="navbar navbar-default">
            <div class="navbar-header">
              <h1 class="test">
                  <div class="logo">
                    <img v-on:click="showMain" class="centerlogo" src="../assets/PR logo.png" width="50" height="50" alt="Logo">
                  </div>
                  <div class="logodivider"></div>
                <router-link class="big router-link-exact-active" v-bind:to="{name: 'iMain'}">{{ sitename }}</router-link>
              </h1>
            </div>
             
            <h1>
              <p class="inlinetitle"> {{ accounttitle }}</p>
              <p class="inline"> {{this.account}}</p>
              <div class="contractsdivider"></div>
              <router-link class="router-link-exact-active" v-bind:to="{name: 'Contracts'}">{{ contractslink }}</router-link>
              <div class="contractsdivider"></div>
              <img class="pointer" v-on:click="showContracts" src="../assets/bell_without_notif.png" width="40" height="40" alt="Logo">
            </h1>
        </div>
    </header>
</template>

<script>
import Web3 from 'web3';
var web3 = new Web3(Web3.givenProvider || 'ws://some.local-or-remote.node:9545');
export default {
  name: 'my-header',
  data () {
    return {
    sitename: "Promise",
    contractslink: "My Contracts",
    account: '',
    accounttitle: "Account: "
    }
  },
  methods: {
    showCreate() {
      this.$router.push({name: 'Create'});
    },
    showContracts() {
      this.$router.push({name: 'Contracts'});
    },
    showMain() {
      this.$router.push({name: 'iMain'});
    },

  },
  created() {
    web3.eth.getAccounts().then(accounts => { 
      let account = accounts[0];
      this.account = account;
      console.log(this.account);
      });
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
a {
  text-decoration: none;
  color: black;
}

.router-link-exact-active {
  font-size: 25px;
  margin: 0%;
  padding: 0%;
  color: rgba(245, 245, 245, 0.976);
}

.logo {
  padding: 0%;
  margin: 0%;
  display: inline;
}

h1 {
  margin: 0;
  padding: 0%;
  margin-top: 0%;
  padding-top: 0%;
  line-height: 20%;
}

.centerlogo {
  display: inline;
  margin-left: auto;
  margin-right: auto;  
  cursor: pointer;  
}

.logodivider {
  width:5px;
  height:auto;
  display:inline-block;
}

.contractsdivider {
  width:15px;
  height:auto;
  display:inline-block;
}

.pointer {
  cursor: pointer;  
}

.big{
  font-size: 25px;
}

header {
  background-color:#688EA6;
  -moz-box-shadow: 0 6px 6px -6px #5c7789c1;
  -webkit-box-shadow: 0 6px 6px -6px #5c7789c1;
  box-shadow: 0 6px 6px -6px #5c7789c1;
}

.inlinetitle {
  font-size: 15px;
  display: inline;
  color: #404040;
  text-align: right;
}

.inline {
  font-weight: normal;
  font-size: 15px;
  display: inline;
  color: #404040;
  text-align: right;
}

.divider {
  width:300px;
  height:auto;
  display:inline;
}
</style>
