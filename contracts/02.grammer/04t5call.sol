pragma solidity ^0.8.0;

contract Callee {
    uint256 value;

    function getValue() public view returns (uint256) {
        return value;
    }

    function setValue(uint256 value_) public payable {
        require(msg.value > 0);
        value = value_;
    }
}

contract Caller {
    constructor() payable {}
    receive() external payable { }
    function callSetValue(address callee, uint256 value) public returns (bool success,bytes memory returnData) {
        // call setValue()
        // 错误写法
        //bytes memory payload = abi.encodeWithSignature("setValue()",value);
        bytes memory payload = abi.encodeWithSignature("setValue(uint256)",value);
        (success,returnData) = callee.call{value:value}(payload);
        require(success,"call function failed");
        return (success,returnData);
    }
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}
