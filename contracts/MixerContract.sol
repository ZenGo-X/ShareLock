pragma solidity ^0.5.8;

contract MixerContract {

    mapping(address => MixingSession) public sessions;
    uint public amt;

    struct MixingSession {
        uint arrivedAmount;
        uint timeOut; //time of last depositor deposited + 1 hour
        address[] senderAddresses;
    }

    constructor (uint mixedAmt) public {
        amt = mixedAmt;
    }

    //Deposit dirty coins in the mixer
    function sendDirtyCoins(address A) public payable {//A is the DKG address
        require(msg.value >= amt, "You should send at least amt wei ether!");
        sessions[A].arrivedAmount += msg.value;
        sessions[A].senderAddresses.push(msg.sender);
        sessions[A].timeOut = now + 3600;

    }

    //If threshold signing is successful, 1 can issue and send out coins to receivers
    function payOutCleanCoins(address A, address[] memory P, uint8 v, bytes32 r, bytes32 s) public {
        require(sessions[A].timeOut > now, "Participants should have withdrawn clean coins earlier!");
        require(sessions[A].arrivedAmount != 0, "This mixing session is already over!");
        require(sessions[A].arrivedAmount == P.length, "Not all participants deposited!");
        require(ecrecover(keccak256(abi.encode(P)), v, r, s)==A, "Threshold sig is not valid"); //check whether the payout addresses are signed
        for(uint i=0; i < P.length; i++) {
            address(uint160(P[i])).transfer(amt);
        }
        msg.sender.transfer(sessions[A].arrivedAmount-P.length*amt); //any surplus is provided to the one who sends the tx
        sessions[A].arrivedAmount = 0;

    }

    //If threshold signing fails, participants can get back their coins when timeout expires
    function payBackDirtyCoins(address A, uint index) public {
        require(now > sessions[A].timeOut, "You cannot withdraw dirty coins before timeout expires!");
        require(sessions[A].senderAddresses[index] == msg.sender, "You are not entitled to receive dirty coins!");
        msg.sender.transfer(amt);
        sessions[A].senderAddresses[index] = address(0);
    }
}