import "./01Tokenv1.sol";
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenBank {
    // IERC20的使用
    IERC20 public token;
    //event的使用
    event Deposit(address indexed from,address indexed to, uint256 amount);
    event Withdraw(address indexed from,address indexed to, uint256 amount);

    mapping (address=>uint256) balances;
    constructor(address tokenAddress){
        token = IERC20(tokenAddress);//构造时写法
    }
    
    
    // 存入 Token
    function deposit(uint256 amount) external {
        require(amount > 0,"amount must bigger than 0");
        token.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender]+=amount;
        emit Deposit(msg.sender, address(this), amount);
    }
    
    // 取出 Token
    function withdraw(uint256 amount) external {
        require(amount>0,"amount  must bigger  than  0");
        require(amount<=balances[msg.sender],"insufficient balance");
        balances[msg.sender]-=amount;
        token.transfer(msg.sender, amount);
        emit  Withdraw(address(this), msg.sender, amount);
    }
    function getBalance(address user) view public returns(uint){
        return balances[user];
    }
}