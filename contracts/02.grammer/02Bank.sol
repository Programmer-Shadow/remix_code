// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
interface IBank {
    function sendeth(address payable to, uint amount) external;
    function withdraw(address payable to) external;
}
contract Bank is IBank {
    address public owner;
    mapping(address => uint) public deposits;
    constructor() payable {
        owner = msg.sender;
    }
    receive() external payable virtual {
        deposits[msg.sender] += msg.value;
    }
    function getOwner() public view returns (address) {
        return owner;
    }
    function getbalance() public view returns (uint) {
        return address(this).balance;
    }
    function sendeth(address payable to, uint amount) public virtual {
        (bool success, ) = to.call{value: amount}("");
        require(success, "not success");
    }
    function withdraw(address payable to) public {
        require(owner == msg.sender, "not owner");
        (bool success, ) = to.call{value: address(this).balance}("");
        require(success, "not success3");
    }
}