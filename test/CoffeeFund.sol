// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CoffeeFund} from "../src/CoffeeFund.sol";

contract CoffeeFundTest is Test {
    CoffeeFund public fund;

    function setUp() public {
        fund = new CoffeeFund();
    }

    function test_case() public pure {
        assertEq(true, true);
    }
}
