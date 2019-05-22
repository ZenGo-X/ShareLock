const MixerContract = artifacts.require("MixerContract");

contract("MixerContract", accounts => {
  let contractInstance;
  it("1 ether should be set as the mixed amount!", () =>
    MixerContract.deployed()
      .then(instance => instance.amt.call())
      .then(balance => {
        assert.equal(
          balance.valueOf(),
          1000000000000000000,
          "The to-be-mixed amount wasn't set properly!"
        );
      }));

  let DKGAddress = "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c";
  it("Valid deposit should be accepted by the mixer contract!", function() {
  return MixerContract.deployed().then(function(instance) {
         contractInstance = instance;
         return contractInstance.sendDirtyCoins(DKGAddress,{from: accounts[1], value:1000000000000000000});
      }).then(function(txReceipt) {
         console.log("Gas cost of the deposit tx: ",txReceipt.receipt.gasUsed);
         return contractInstance.sessions.call(DKGAddress);
      }).then(function(sessionA) {
         assert.equal(sessionA.arrivedAmount.toString(), "1000000000000000000", "The to-be-mixed amount wasn't set properly!");
      });
  })
});
