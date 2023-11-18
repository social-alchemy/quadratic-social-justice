// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract IBettingGame_ERC20 {
    function createBet(string memory question, uint256 amount) public;
    function joinBet(bytes32 questionId, uint256 amount) public;
    function settleBet(bytes32 questionId) public;
}
