<template>
   <footer>
       <!-- <router-link class="footer" v-bind:to="{name: 'Terms'}">Terms &amp; Conditions</router-link> -->
       <p class="footer">Terms &amp; Conditions</p>
       <div class="divider"></div>
       <!-- <router-link class="footer" v-bind:to="{name: 'Privacy'}">Privacy Policy</router-link> -->
       <p class="footer">Privacy Policy</p>
       <div class="divider"></div>
       <!-- <router-link class="footer" v-bind:to="{name: 'Contact'}">Contact Us</router-link> -->
       <p class="footer">Contact Us</p>
   </footer>
</template>

<script>
export default {
  name: 'my-footer',
  methods: {
    showContracts() {
      this.$router.push({name: 'Contracts'});
    }

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
  font-size: 20px;
}

.footer
{
    color: #404040;
    height: 60px;
    padding: 20px;
    bottom: 0;
}

p { display: inline }
</style>
