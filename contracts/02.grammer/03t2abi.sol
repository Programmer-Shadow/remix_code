pragma solidity ^0.8.0;

contract ABIEncoder {
    function encodeUint(uint256 value) public pure returns (bytes memory) {
        return abi.encode(value);
    }
    function encodeMultiple(
        uint num,
        string memory text) public pure returns (bytes memory) {
       return abi.encode(num,text);
    }
}

contract ABIDecoder {
    function decodeUint(bytes memory data) public pure returns (uint) {
        abi.decode(data,(uint256));
    }
    function decodeMultiple( bytes memory data) public pure returns (uint, string memory) {
        return abi.decode(data, (uint,string));
    }
}
contract c{
    function testRoundTrip() public pure returns (uint256, string memory) {
    uint256 num = 2025;
    string memory txt = "Hello Web3";
    bytes memory encoded = abi.encode(num, txt);
    (uint256 decodedNum, string memory decodedTxt) = abi.decode(encoded, (uint256, string));
    return (decodedNum, decodedTxt);
}
}