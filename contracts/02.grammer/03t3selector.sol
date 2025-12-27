pragma solidity ^0.8.0;

contract FunctionSelector {
    uint256 private storedValue;

    function getValue() public view returns (uint) {
        return storedValue;
    }

    function setValue(uint value) public {
        storedValue = value;
    }

    function getFunctionSelector1() public pure returns (bytes memory) {
        bytes memory a =  abi.encodeWithSignature("getValue()");
        return a;
    }

    function getFunctionSelector2() public pure returns (bytes memory) {
        //
        bytes memory a =  abi.encodeWithSignature("setValue()");
        return a;
    }
}
