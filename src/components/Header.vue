<template>
    <header>
        <div class="navbar navbar-default">
            <div class="navbar-header">
              <h1 class="test">
                 <div class="logo"><img v-on:click="showMain" class="centerlogo" src="../assets/hand_shake_logo.png" width="40" height="40" alt="Logo"></div>
                <router-link class="router-link-exact-active" v-bind:to="{name: 'iMain'}">{{ sitename }}</router-link>
              </h1>
            </div>
              <h1>
                <router-link class="router-link-exact-active" v-bind:to="{name: 'Contracts'}">{{ contractslink }}</router-link>
                <div class="contractsdivider"></div>
                <img class="pointer" v-on:click="showContracts" src="../assets/bell_without_notif.png" width="40" height="40" alt="Logo">
              </h1>
        </div>
    </header>
</template>

<script>
export default {
  name: 'my-header',
  data () {
    return {
    sitename: "Promise",
    contractslink: "My Contracts"
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
  color: #174f7e;
  font-size: 25px;
  margin: 0%;
  padding: 0%;
}

.logo {
  padding: 0%;
  margin: 0%;
}

h1 {
  margin: 0;
  padding: 0%;
  margin-top: 0%;
  padding-top: 0%;
  line-height: 20%;
}

.centerlogo {
  display: block;
  margin-left: auto;
  margin-right: auto;  
  cursor: pointer;  
}

.contractsdivider{
  width:15px;
  height:auto;
  display:inline-block;
}

.pointer{
  cursor: pointer;  
}
</style>
