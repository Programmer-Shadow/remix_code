pragma solidity ^0.8.0;

contract Caller {
    uint public balance;
    function sendEther(address to, uint256 value) public returns (bool) {
        // 使用 call 发送 ether
        (bool success,) = to.call{value:value,gas:10000}("sendEther failed");
        require(success,"sendEther failed");
        return success;
    }
    constructor() payable {}
    receive() external payable {}
}
