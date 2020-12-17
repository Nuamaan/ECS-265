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
export default {
  name: 'welcome',
  props: ["isLoading"],
  data () {
    return {
  
    }
  },
  mounted() {
    setTimeout( () => this.$router.push({name: 'iMain'}), 2000);
  },
  methods: {

  },
  components: { }
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

.logo {
  position: absolute;
  display: inline-block;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.logo p {
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