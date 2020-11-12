<template>
    <div class="welcome">
        <main class="center-screen">
            <div class="logo"><img class="centerlogo" src="../assets/hand_shake_logo.png" width="100" height="100" alt="Logo"></div>
            <h1 class="center-screen">Promise</h1>
        </main>
    </div>
</template>

<script>
export default {
  name: 'welcome',
  data () {
    return {
  
    }
  },
  methods: {
    showMain() {
      this.$router.push({name: 'Main'});
    },
    delay(ms) {

      const startPoint = new Date().getTime();
      while (new Date().getTime() - startPoint <= ms) {
        /* wait */
      }

      /* Transition to main page */
      this.showMain();

    }
  },
  components: { },
  created: function() {
    axios.get('/static/products.json')
    .then((response) =>{
      this.products=response.data.products;
      console.log(this.products);
    });
  }
}
</script>