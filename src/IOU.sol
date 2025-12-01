// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract IOU {
    IERC20 public usdt;
    address public owner;

    constructor(IERC20 token) {
        usdt = token;
        owner = msg.sender;
    }

    error NoTokensToWithdraw(address user, uint256 requested);
    error NotAnOwner(address user);

    mapping(address => uint256) public debts;

    function withdraw(uint256 amount) external {
        uint256 debtSize = debts[msg.sender];
        uint256 toWithdraw = (debtSize > amount) ? amount : debtSize;
        require(toWithdraw > 0, NoTokensToWithdraw(msg.sender, amount));
        usdt.transfer(msg.sender, toWithdraw);
        debts[msg.sender] -= toWithdraw;
    }

    function accrue(address user, uint256 amount) external {
        require(msg.sender == owner, NotAnOwner(msg.sender));
        debts[user] += amount;
    }
}
