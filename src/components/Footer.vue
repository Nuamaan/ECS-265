<template>
   <footer>
       <router-link class="footer" v-bind:to="{name: 'Terms'}">Terms &amp; Conditions</router-link>
       <div class="divider"></div>
       <router-link class="footer" v-bind:to="{name: 'Privacy'}">Privacy Policy</router-link>
       <div class="divider"></div>
       <router-link class="footer" v-bind:to="{name: 'Contact'}">Contact Us</router-link>
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
    color: #7d7e7e;;
}
</style>
