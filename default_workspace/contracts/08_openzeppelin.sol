// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// import “./filename.sol”; // 将 “filename” 中的所有全局符号导入到当前文件中
// import { Token as T1} from "./token.sol";
// import { Token } from "./token.sol";
// 能直接加载github上的库 相当于把代码拷贝到这个import的位置
import { Address } from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";


contract TokenEx {
    // 语法糖
    using Address for address payable;

    function newCall2(address payable c) public {
        c.sendValue(100);
        // Address.sendValue(c, 100);
    }

}