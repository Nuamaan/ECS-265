<template>
  <div class="viewcontract">
    <my-header></my-header>
    <main class="center">
      <h1>Contract View</h1>
    </main>
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'
export default {
  name: 'view-contract',
  data () {
    return {
  
    }
  },
  methods: {

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