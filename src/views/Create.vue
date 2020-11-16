<template>
  <div class="create">
    <my-header></my-header>
    <main class="center">
      <h1>Start Creating</h1>
      <form action="">
        <div class="form-group">
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="1" placeholder="Recipient(s): Alice's Public Key"></textarea>
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="1" placeholder="Contract Title"></textarea>
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" placeholder="Write your contract here..."></textarea>
        </div>
      </form>
      </main>
            <p>Want to share your contract?</p>
            <div class="center">
        <button type="button" class="btn btn-light btn-lg" v-on:click="showConfirmation">Send &amp; Sign Message</button>
      </div>
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
    showConfirmation() {
      this.$router.push({name: 'Confirmation'});
    }
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


<style scoped>

textarea{
  background-color:#d7dce2;
  border: #7d7e7e solid;
  border-width: 2px;
  margin-bottom: 10px;
}

p{
  padding-left: 395px;
}

img
{
  background: none;
}

</style>