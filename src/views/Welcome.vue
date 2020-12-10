<template>
    <div :class="{ fadeout: !isLoading }">
        <main>
          <div class="logo">
            <img src="../assets/PR logo.png" width="200" height="200" alt="Logo">
            <p> Promise </p>
          </div>
        </main>
    </div>
</template>

<script>
// import Metamask from '../components/Metamask.vue'
export default {
  name: 'welcome',
  props: ["isLoading"],
  // beforeCreate () {
  //   console.log('registerWeb3 Action dispatched from Welcome.vue')
  //   this.$store.dispatch('registerWeb3')
  // },
  data () {
    return {
  
    }
  },
  mounted() {
    setTimeout( () => this.$router.push({name: 'iMain'}), 2000);
  },
  methods: {
    // showMain() {
    //   this.$router.push({name: 'Main'});
    // },
    // delay(ms) {
    //   const startPoint = new Date().getTime();
    //   while (new Date().getTime() - startPoint <= ms) {
    //     /* wait */
    //   }
    //   /* Transition to main page */
    //   this.showMain();
    // }
  },
  components: { }
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
main {
    background-color: #d7dce2;
    padding-bottom: 58px;
    min-height: 100vh;
}

.fadeout {
  animation: fadeout 4s forwards;
  animation-delay: 1s;
}
@keyframes fadeout {
  to {
    opacity: 0;
    visibility: hidden;
  }
}
.logo
{
  position: absolute;
  display: inline-block;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.logo p 
{
  position: absolute;
  width: 100%;
  text-align: center;
  bottom: 0;
  left: 0;
  top: 175px;
  color: #174f7e;
  font-weight: bold;
  font-size: 50px;
}
</style>