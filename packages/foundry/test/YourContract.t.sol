// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/RealityETH_v3_0.sol";

contract YourContractTest is Test {
    RealityETH_v3_0 public yourContract;

    function setUp() public {
        yourContract = new RealityETH_v3_0();
    }

    function testMessageOnDeployment() public view {
        // require(
        //     keccak256(bytes(yourContract.greeting())) ==
        //         keccak256("Building Unstoppable Apps!!!")
        // );
    }

    function testSetNewMessage() public {
        // yourContract.setGreeting("Learn Scaffold-ETH 2! :)");
        // require(
        //     keccak256(bytes(yourContract.greeting())) ==
        //         keccak256("Learn Scaffold-ETH 2! :)")
        // );
    }
}
