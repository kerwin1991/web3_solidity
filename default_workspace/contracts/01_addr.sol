// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;


contract testAddr {


    uint public deposited; // 充值
    address public deployer; // 谁充的？

    // 表示创建合约时，必须给他充值
    constructor() payable {
        deployer = msg.sender;
        deposited = msg.value;
    }

    // 合约余额大于10 就给x转10 eth
    function testTrasfer(address payable x) public {
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
