pragma solidity ^0.8.0;

contract Counter {
    uint public counter;
    address public sender;

    function count() public {
        counter += 1;
        sender = msg.sender;
        revert("xxx");
    }

    receive() external payable {}
}

contract CallTest {
    uint public counter;
    address public sender;
    uint public counter2;
    function callCount(Counter c) public {
        c.count();
    }

    // 只是调用代码，合约环境还是当前合约。
    function lowDelegatecallCount(address addr) public {
        bytes memory methodData = abi.encodeWithSignature("count()");
        (bool success, ) = addr.delegatecall(methodData);
        if (success == false) counter2 = 2;
    }

    function lowCallCount(address addr) public {
        bytes memory methodData = abi.encodeWithSignature("count()");
        (bool success, ) = addr.call(methodData);
        if (success == false) counter2 = 2;
    }
}
