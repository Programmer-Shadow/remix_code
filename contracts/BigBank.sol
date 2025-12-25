// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "./Bank.sol";
contract BigBank is Bank{


    modifier minAmount(uint amount){
        require(amount > 0.001 ether,"amount not >  0.001 ETH");
        _;
    }
    function sendeth(address payable to, uint amount) override public minAmount(amount){
        super.sendeth(to, amount);
    }

}