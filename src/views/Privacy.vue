<template>
  <div class="privacy">
    <my-header></my-header>
    This is the privacy page.
    <my-footer></my-footer>
  </div>
</template>

<script>
import MyHeader from '../components/Header.vue'
export default {
  name: 'privacy',
  data () {
    return {
  
    }
  },
  components: { MyHeader }
}
</script>