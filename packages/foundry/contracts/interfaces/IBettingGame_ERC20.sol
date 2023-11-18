// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IBettingGame_ERC20 {
    function createBet(string memory question, uint256 amount) external;
    function joinBet(bytes32 questionId, uint256 amount) external;
    function settleBet(bytes32 questionId) external;
}
