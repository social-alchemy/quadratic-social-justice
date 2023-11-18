// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../contracts/BettingGame.sol";


contract MockRealityETH is IRealityETH {
    mapping(bytes32 => bytes32) public answers;

    function askQuestion(uint256, string memory, address, uint32, uint32, uint256) external payable override returns (bytes32 questionId) {
        questionId = keccak256(abi.encodePacked(msg.sender, address(this), msg.value));
        answers[questionId] = bytes32(0); // default answer
    }

    function resultFor(bytes32 questionId) external view override returns (bytes32) {
        return answers[questionId];
    }

    function setAnswer(bytes32 questionId, bytes32 answer) public {
        answers[questionId] = answer;
    }
}

contract BettingGameTest is DSTest {
    BettingGame bettingGame;
    MockRealityETH mockRealityETH;

    function setUp() public {
        mockRealityETH = new MockRealityETH();
        bettingGame = new BettingGame(address(mockRealityETH));
    }

    function testCreateBet() public {
        bytes32 questionId = bettingGame.createBet{value: 1 ether}("Will it rain tomorrow?", address(0), 0, 0, 0);
        Bet memory bet = bettingGame.bets(questionId);
        assertEq(bet.amount, 1 ether);
    }

    function testJoinAndSettleBet() public {
        bytes32 questionId = bettingGame.createBet{value: 1 ether}("Will it rain tomorrow?", address(0), 0, 0, 0);
        bettingGame.joinBet{value: 1 ether}(questionId);
        mockRealityETH.setAnswer(questionId, bytes32(uint256(1))); // Set the answer to 'yes'

        uint256 initialBalance = address(this).balance;
        bettingGame.settleBet(questionId);
        uint256 finalBalance = address(this).balance;

        assertEq(finalBalance, initialBalance + 1 ether); // Check if the winner received the prize
    }
}
