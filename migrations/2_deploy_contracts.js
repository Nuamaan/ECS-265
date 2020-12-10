const SolidPromise = artifacts.require("SolidPromise");

module.exports = function(deployer) {
  deployer.deploy(SolidPromise);
};
