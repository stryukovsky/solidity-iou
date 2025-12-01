// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {IOU} from "../src/IOU.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {TestToken} from "./TestToken.sol";

contract CounterTest is Test {
    IOU protocol;
    IERC20 usdt;

    function setUp() public {
        usdt = new TestToken();
        protocol = new IOU(usdt);
        usdt.transfer(address(protocol), 1000 ether);
    }

    function test_BasicScenario() public {
        protocol.accrue(address(1), 10 ether);
        protocol.accrue(address(1), 10 ether);
        protocol.accrue(address(1), 10 ether);
        
        vm.prank(address(1));
        protocol.withdraw(30 ether);
    }
}
