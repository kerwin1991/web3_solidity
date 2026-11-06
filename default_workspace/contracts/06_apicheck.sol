// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ABICheck { 

    uint128 public  a;

    address public  sender;


    function addOne1() public {
        a = a+1;
    }


    function addOne2(uint128 _a) public {
        a = a+_a;
    }


    function addOne3(uint128 _a, uint128 _b) public {
        a = a +_a +_b;
    }

    function deposit() public payable{
        sender = msg.sender;
    }

}

contract ABICheck2 { 

    constructor() payable {
        
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

}