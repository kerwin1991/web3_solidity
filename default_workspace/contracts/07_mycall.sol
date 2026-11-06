// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Counter {
    // 跟 CompareCallApi 合约一样 都有 counter 变量
    uint public counter;
    address public sender;
    function count() public {
        counter +=1;
        sender = msg.sender;
    }
    fallback() external { }
    receive() external payable { }
}



contract CompareCallApi {

    // 跟 Counter 合约一样 都有 counter变量
    uint public counter;
    address public sender;


    // 会在当前的上下文执行 相当于把上个合约的代码加载的这个合约的上下文 执行count方法，变更的是这个合约的counter
    // 执行完 CompareCallApi.counter 会+1
    function lowDelegatecallCount(address addr) public {
        bytes memory methodData = abi.encodeWithSignature("count()");
        addr.delegatecall(methodData);
    }

    // 跟下面的 callCount 一样，会有上下文切换，会在 Counter 的上下文执行 count方法
    // 执行完 Counter.counter 会+1
    function lowCallCount(address addr) public {
        bytes memory methodData = abi.encodeWithSignature("count()");
        addr.call(methodData);
    }

    // 执行完 Counter.counter 会+1
    function callCount(Counter c) public {
        c.count();
    }

}