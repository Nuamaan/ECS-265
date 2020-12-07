import Vue from 'vue'
import VueRouter from 'vue-router'
import Welcome from '../views/Welcome.vue'
import Main from '../views/Main.vue'
import Create from '../views/Create.vue'
import Contact from '../views/Contact.vue'
import Privacy from '../views/Privacy.vue'
import Share from '../views/Share.vue'
import Terms from '../views/Terms.vue'
import Contracts from '../views/Contracts.vue'
import Confirmation from '../views/Confirmation.vue'
import Test from '../views/Test.vue'
import ViewContract from '../views/ViewContract.vue'
import EditContract from '../views/EditContract.vue'

Vue.use(VueRouter)

/**
 * For our Promise app, we'll create five routes.
 * 
 * Main Route: Displays "What We Do" page.
 * Create Route: Allows user to create a contract.
 * Contracts Route: Allows user to view pending/confirmed contracts.
 * Edit Route: Allows user to edit contracts.
 * Confirmation Route: Displays a confirmation page.
 */

const routes = [
  {
    path: '/',
    name: 'Welcome',
    component: Welcome,
    props: true
  },
  {
    path: '/imain',
    name: 'iMain',
    component: Main,
    props: true
  },
  {
    path: '/create',
    name: 'Create',
    component: Create,
    props: true
  },
  {
    path: '/contracts',
    name: 'Contracts',
    component: Contracts,
    props: true
  },
  {
    path: '/contact',
    name: 'Contact',
    component: Contact,
    props: true
  },
  {
    path: '/privacy',
    name: 'Privacy',
    component: Privacy,
    props: true
  },
  {
    path: '/share',
    name: 'Share',
    component: Share,
    props: true
  },
  {
    path: '/terms',
    name: 'Terms',
    component: Terms,
    props: true
  },
  {
    path: '/confirmation',
    name: 'Confirmation',
    component: Confirmation,
    props: true
  },
  {
    path: '/test',
    name: 'Test',
    component: Test,
    props: true
  },
  {
    path: '/view-contract',
    name: 'ViewContract',
    component: ViewContract,
    props: true
  },
  {
    path: '/edit-contract',
    name: 'EditContract',
    component: EditContract,
    props: true
  }

]

const router = new VueRouter({
  routes
})

export default router
