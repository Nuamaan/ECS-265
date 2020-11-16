var Promise = artifacts.require("./Promise.sol");

module.exports = function(deployer) {
  deployer.deploy(Promise);
};
