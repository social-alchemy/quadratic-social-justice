// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../contracts/BettingGame.sol";
import "../contracts/interfaces/IReality.sol";

contract MockRealityETH is IReality {
    mapping(bytes32 => bytes32) public answers;

    function askQuestion(uint256, string memory, address, uint32, uint32, uint256)
        external
        payable
        override
        returns (bytes32 questionId)
    {
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

contract BettingGameTest is Test {
    BettingGame bettingGame;
    MockRealityETH mockRealityETH;

    function setUp() public {
        mockRealityETH = new MockRealityETH();
        bettingGame = new BettingGame(address(mockRealityETH));
    }

    function testCreateBet() public {
        bytes32 questionId = bettingGame.createBet{value: 1 ether}("Will it rain tomorrow?", address(0), 0, 0, 0);
        (,, uint256 amount,,) = bettingGame.bets(questionId);
        assertEq(amount, 1 ether);
    }

    function testJoinAndSettleBet() public {
        address player1 = vm.addr(1);
        vm.deal(player1, 2 ether);
        vm.prank(player1);
        bytes32 questionId = bettingGame.createBet{value: 1 ether}("Will it rain tomorrow?", address(0), 0, 0, 0);

        address player2 = vm.addr(2);
        vm.deal(player2, 2 ether);
        vm.prank(player2);
        bettingGame.joinBet{value: 1 ether}(questionId);
        mockRealityETH.setAnswer(questionId, bytes32(uint256(0))); // Set the answer to 'yes'

        uint256 initialBalance = address(player2).balance;
        console.log("Initial balance: %s", initialBalance);
        vm.prank(player1);
        bettingGame.settleBet(questionId);
        uint256 finalBalance = address(player2).balance;
        console.log("finalBa balance: %s", finalBalance);

        assertTrue(finalBalance == initialBalance + 1 ether); // Check if the winner received the prize
    }
}
