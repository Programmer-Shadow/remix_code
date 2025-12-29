import "./01Tokenv1.sol";
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenBank {
    // IERC20的使用
    IERC20 public token;
    //event的使用 一般不写第二个参数，to就是到自己这个地址，显而易见
    //event Deposit(address indexed from,address indexed to, uint256 amount);
    //event Withdraw(address indexed from,address indexed to, uint256 amount);
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    mapping (address=>uint256) balances;
    constructor(address tokenAddress){
        token = IERC20(tokenAddress);//构造时写法
    }
    
    
    // 存入 Token
    function deposit(uint256 amount) external {
        require(amount > 0,"amount must bigger than 0");
        require(amount <= token.balanceOf(msg.sender),"sender insufficient balance");
        bool success = token.transferFrom(msg.sender, address(this), amount);
        require(success,"transfer failed");
        balances[msg.sender]+=amount;
        emit Deposit(msg.sender, amount);
    }
    
    // 取出 Token
    function withdraw(uint256 amount) external {
        require(amount>0,"amount  must bigger  than  0");
        require(amount<=balances[msg.sender],"insufficient balance");
        balances[msg.sender]-=amount;
        bool success = token.transfer(msg.sender, amount);
        require(success,"transfer failed");
        emit  Withdraw(msg.sender, amount);
    }
    function getBalance(address user) view public returns(uint){
        return balances[user];
    }
}