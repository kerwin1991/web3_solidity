// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;


contract ContA {
    uint256 public a;

    mapping(address => uint256) public addrNumMapping;

    constructor(uint _a){
        a = _a;
    }

    function modify1(uint256 _a) public {
        a = _a;
    }

    modifier checkNum(uint256 val) {
        require(val >= 10, "val must be >= 10");
        _;
    }

    function setNum(uint256 val) public checkNum(val) {
        addrNumMapping[msg.sender] = val;
    }



    function createContract(uint128 _num) public returns(uint128)  {
        ContB contb = new ContB();
        return contb.addNum(_num);
    }


}

contract ContB {

    function addNum(uint128 _a) public pure returns (uint128){
        return _a + 10;
    }

}
