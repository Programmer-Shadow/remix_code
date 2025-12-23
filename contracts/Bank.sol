// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
contract Bank {
    address public owner;
    mapping(address => uint) public deposits;
    uint balance;

    constructor() payable{
        owner = msg.sender;
    }
    receive() external payable{
        deposits[msg.sender] = msg.value;
    }
    function getOwner() public view returns(address){
        return owner;
    }
    function sendeth(address payable x,uint amount) payable public{
        (bool success,) = x.call{value:amount}("");
        require(success,"not success");
    }
    function getbalance() view public returns(uint){
        return address(this).balance;
    }
    function withdraw(address payable x) public {
        require(x == msg.sender,"not owner");
        (bool success,) = x.call{value:address(this).balance}("");
        require(success,"not success1");
    }
}
