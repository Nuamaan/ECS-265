// Import contracts
// import Migrations from '../build/contracts/Migrations.json'
import Promise from '../build/contracts/Promise.json'


/**
 * Contracts is an array of either contract artifact files or Web3 contract objects. 
 * The objects have a contractName and web3Contract key.
 */

const options = {
    contracts: [Promise],
    // events: {
    //   Promise: [
    //     "notify"
    //   ]
    // },
    polls: {
      blocks: 3000
    },
    syncAlways: false,
    web3: {
      fallback: {
        type: "ws",
        url: "ws://127.0.0.1:8545"
      }
    }
  }

export default options;