<template>
  <div class="main">
    <my-header></my-header>
    <main class="center">
      <h1>What We Do</h1>
      <br>
      <p>
        Making informal agreements is so prevalent in our global society that many often neglect to take into consideration the ramifications that such agreements can hold.
        With our technological innovation, we aim to put an end to the majority of lawsuits that stem from the broken terms of a verbal contract. 
        Our system allows users to quickly and easily generate a binding agreement between two or more parties, and these agreements will be authenticated by a blockchain.
      </p>
      <br>
      <br>
      <button type="button" class="btn btn-light btn-lg" v-on:click="showCreate">Create a contract</button>
      <!-- <div class="divider"></div>
      <button type="button" class="btn btn-light btn-lg" v-on:click="showShare">Share your address</button> -->
    </main>
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'
export default {
  name: 'imain',
  data () {
    return {
  
    }
  },
  methods: {
    showCreate() {
      this.$router.push({name: 'Create'});
    },
    // showShare() {
    //   this.$router.push({name: 'Share'});
    // },
    delay(ms) {
      const startPoint = new Date().getTime();
      while (new Date().getTime() - startPoint <= ms) {
        /* wait */
      }
    }
  },
  components: { MyHeader, MyFooter }
  // created: function() {
    // axios.get('/static/products.json')
    // .then((response) =>{
    //   this.products=response.data.products;
    //   console.log(this.products);
    // });
    // axios.get('/static/products.json').then((response) =>{
    //   this.products=response.data.products;
    //   console.log(this.products);
    // }).catch((error) => {
    //     console.warn('Not good man :(');
    // });
  // }
}
</script>


<style scoped>
.main-info {
  border:5px solid #b2d8d8;
  border-width: 25%;
  background-color: #E0E0E0;
  border-radius: 5px;
  padding: 10px 10px 10px 10px;

}
</style>