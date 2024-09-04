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
        coffeeFund.registerUser("Josef");
        console.log("User registered:", coffeeFund.getUserName());

        // Add other user
        address jeanLucAddress = address(0x456);
        coffeeFund.registerOtherUser(jeanLucAddress, "Jean-luc");
        console.log("Other user registered:", coffeeFund.userNames(jeanLucAddress));

        // Transfer funds from sender (Josef) to user (Jean-luc)
        coffeeFund.transfer{value: 1 ether}(jeanLucAddress);
        console.log("Transferred funds:", coffeeFund.getCoffeeFunds(jeanLucAddress));

        // Withdraw funds should fail 
        coffeeFund.withdraw(0.5 ether);

        vm.stopBroadcast();
    }
}
