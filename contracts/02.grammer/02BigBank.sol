pragma solidity ^0.8.3;
import "./02Bank.sol";
contract BigBank is Bank{
    constructor() payable {
        owner = msg.sender;
    }
    receive() external payable override minAmount(msg.value){ 
    }
    modifier minAmount(uint amount){
        require(amount > 100,"amount not >  100");
        _;
    }
    function sendeth(address payable to, uint amount) override public minAmount(amount){
        super.sendeth(to, amount);
    }
    function changeAdmin(address newAdmin) public{
        require(owner == msg.sender,"change people is not owner");
        owner = newAdmin;
    }
}
