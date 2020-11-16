<template>
  <div class="confirmation">
    <my-header></my-header>
    <main class="center">
      <h1>Confirmation</h1>
      <br>
      <p>
       Your contract has been successfully sent! 
       A notification has been sent to the parties. 
       Please wait for their signature. 
       You can check the status of your contract under 'My Contracts'.
      </p>
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

  },
  components: { MyHeader, MyFooter },
  created: function() {
    axios.get('/static/products.json')
    .then((response) =>{
      this.products=response.data.products;
      console.log(this.products);
    });
  }
}
</script>