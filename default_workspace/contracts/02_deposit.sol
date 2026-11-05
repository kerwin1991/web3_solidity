// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;


contract My_Deposit {


    uint public deposited; // 充值
    address public deployer; // 谁充的？

    // 表示创建合约时，必须给他充值
    // 方法体可以没有接收充值的代码，会自动充值 放到合约的balance中
    // 外部定义的状态只是副本 不是实际存储的余额的字段
    constructor() payable {
        // deployer = msg.sender;
        // deposited = msg.value;
    }

    // 把钱提走
    function withdrawTo(address payable x) public {
        // address myAddr = address(this);
        // if (myAddr.balance >= 10 ether){
        //     // x.transfer(10 ether);
        // }
        uint256 amount = 10 ether;
        if (address(this).balance >= amount) {
            (bool success, ) = x.call{value: amount}("");
            require(success, "Transfer failed");
        }
        
    }


}
