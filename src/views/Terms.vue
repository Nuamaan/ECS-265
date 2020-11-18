<template>
  <div class="terms">
    <my-header></my-header>
    This is the terms page.
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
export default {
  name: 'terms',
  data () {
    return {
  
    }
  },
  components: { MyHeader }
  // created: function() {
  //   axios.get('/static/products.json')
  //   .then((response) =>{
  //     this.products=response.data.products;
  //     console.log(this.products);
  //   });
  // }
}
</script>