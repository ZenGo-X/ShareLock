const MixerContract = artifacts.require("./MixerContract.sol");

module.exports = function(deployer) {
  deployer.deploy(MixerContract, "1000000000000000000"); //1 ether is the to-be-mixed amount
};