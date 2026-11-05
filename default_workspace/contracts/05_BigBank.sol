// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./03_Bank.sol";

/// @title BigBank
/// @notice 继承 Bank，但限制单笔存款必须大于 0.001 ether。
contract BigBank is Bank {
    /// @notice 单笔存款的最低额度（不含本数）。
    uint256 public constant MIN_DEPOSIT = 0.001 ether;

    error DepositTooSmall();

    /// @notice 校验单笔存款金额必须大于 MIN_DEPOSIT。
    modifier onlyLargeDeposit() {
        if (msg.value <= MIN_DEPOSIT) revert DepositTooSmall();
        _;
    }

    /// @notice 存入 ETH，单笔金额必须大于 0.001 ether。
    function deposit() public payable override onlyLargeDeposit {
        super.deposit();
    }
}

/// @title Admin
/// @notice BigBank 的管理员合约。
///         将 BigBank 的管理员权限转移给本合约后，由本合约的 owner
///         触发调用 BigBank.withdraw()，从而提走 BigBank 中的全部 ETH。
contract Admin {
    /// @notice Admin 合约的所有者，部署时确定。
    address public immutable owner;

    /// @notice 受管理的 BigBank 合约。
    BigBank public immutable bigBank;

    event FundsForwarded(address indexed to, uint256 amount);

    error NotOwner();
    error NoFunds();
    error TransferFailed();

    constructor(BigBank _bigBank) {
        owner = msg.sender;
        bigBank = _bigBank;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    /// @notice 以 BigBank 管理员的身份调用 BigBank.withdraw()。
    ///         BigBank 会把资金转给它的 admin（也就是本合约），
    ///         因此本合约需要实现 receive() 才能收款。
    function withdraw() external onlyOwner {
        bigBank.withdraw();
    }

    /// @notice 把本合约收到的 ETH 转给 owner。
    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        if (balance == 0) revert NoFunds();

        (bool success, ) = payable(owner).call{value: balance}("");
        if (!success) revert TransferFailed();

        emit FundsForwarded(owner, balance);
    }

    /// @notice 查询本合约当前持有的 ETH。
    function balance() external view returns (uint256) {
        return address(this).balance;
    }

    /// @notice 接收 BigBank.withdraw() 转来的 ETH。
    receive() external payable {}
}
