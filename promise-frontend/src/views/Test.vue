<template>
 <metamask/>
</template><script>

import Metamask from '../components/Metamask'
export default {
 name: 'test',
 beforeCreate () {
    console.log('registerWeb3 Action dispatched from casino-dapp.vue')
    this.$store.dispatch('registerWeb3')
  },
 components: {
 'metamask': Metamask
 }
}
</script>

<style scoped>
</style>