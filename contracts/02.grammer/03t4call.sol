// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataStorage {
    string private data;

    function setData(string memory newData) public {
        data = newData;
    }

    function getData() public view returns (string memory) {
        return data;
    }
}

contract DataConsumer {
    address private dataStorageAddress;

    constructor(address _dataStorageAddress) {
        dataStorageAddress = _dataStorageAddress;
    }

    // ---------------------- 读取方法 - getData ----------------------

    function getDataByABI() public returns (string memory) {
        // 1. 编码函数签名：getData()
        bytes memory payload = abi.encodeWithSignature("getData()");

        // 2. 低级调用
        (bool success, bytes memory returnData) = dataStorageAddress.call(payload);
        require(success, "call getData failed");

        // 3. 解码返回数据
        return abi.decode(returnData, (string));
    }

    // ---------------------- 写入方法 - 三种不同编码方式 ----------------------

    // 方式1：最常用、最直观的方式
    function setDataByABI1(string calldata newData) public returns (bool) {
        // 使用函数签名字符串进行编码（最推荐日常使用）
        bytes memory payload = abi.encodeWithSignature(
            "setData(string)", 
            newData
        );

        (bool success, ) = dataStorageAddress.call(payload);
        return success;
    }

    // 方式2：使用函数选择器（4 bytes） + 手动拼接参数
    function setDataByABI2(string calldata newData) public returns (bool) {
        // 函数选择器：setData(string) 的前4个字节
        bytes4 selector = bytes4(keccak256("setData(string)"));

        // 编码：选择器 + 参数（记得加abi编码）
        bytes memory payload = abi.encodePacked(
            selector,
            abi.encode(newData)
        );

        (bool success, ) = dataStorageAddress.call(payload);
        return success;
    }

    // 方式3：目前最推荐、安全性最高的写法（0.8.13+ 强烈建议）
    function setDataByABI3(string calldata newData) public returns (bool) {
        // abi.encodeCall 会自动帮你：
        // 1. 计算正确的函数选择器
        // 2. 按照ABI规则正确编码所有参数
        // 3. 类型检查更严格（编译期就能发现很多错误）
        bytes memory payload = abi.encodeCall(
            DataStorage.setData, 
            (newData)
        );

        (bool success, ) = dataStorageAddress.call(payload);
        return success;
    }
}