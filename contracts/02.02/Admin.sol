// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "./Bank.sol";
contract  Admin{
    
    address public owner;
    
    constructor() payable {
        owner = msg.sender;
    }
    receive() external payable { }

    function adminWithdraw(IBank bank) payable public {
        address payable to = payable(address(this));
        bank.withdraw(to);
    }
}