<template>
  <div class="contracts">
    <my-header></my-header>
    <div class="pending center">
      <h2 class="contracts-heading">Pending Contracts</h2>

    </div>
    <div class="signed center">
      <h2 class="contracts-heading">Signed Contracts</h2>

    </div>
    <div class="rejected center">
      <h2 class="contracts-heading">Rejected Contracts</h2>

    </div>
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
import MyFooter from '../components/Footer.vue'
export default {
  name: 'contracts',
  data () {
    return {
  
    }
  },
  components: { MyHeader, MyFooter }
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
.contracts-heading {
  text-align: left;
  display: inline;
}

.pending {
  text-align: center;
}

</style>