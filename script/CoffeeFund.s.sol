// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {CoffeeFund} from "../src/CoffeeFund.sol";

contract CoffeeFundScript is Script {
    CoffeeFund public coffeeFund;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        coffeeFund = new CoffeeFund();

        // Add user
        coffeeFund.registerUser("Josef A");
        console.log("User registered:", coffeeFund.getUserNames(address(this)));

        // Deposit funds
        coffeeFund.deposit{value: 1 ether}(address(this));
        console.log("Deposited funds:", coffeeFund.getCoffeeFunds(address(this)));

        // Withdraw funds
        coffeeFund.withdraw(0.5 ether);

        vm.stopBroadcast();
    }
}
