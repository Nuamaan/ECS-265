const Promis = artifacts.require("Promise");

module.exports = function(deployer) {
  deployer.deploy(Promis);
};
