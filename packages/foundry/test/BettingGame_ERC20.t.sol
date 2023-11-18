// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "forge-std/Test.sol";
import "../contracts/BettingGame_ERC20.sol";
import "../contracts/interfaces/IRealityETH_ERC20.sol";


contract MockERC20 is ERC20 {
    constructor() ERC20("MockToken", "MTK") {
        _mint(msg.sender, 10000 * 10 ** 18);
    }
}

contract MockIRealityETH {
    mapping(bytes32 => bytes32) public answers;
    mapping(bytes32 => string) public questions;

    // Mock function to simulate asking a question
    function askQuestionERC20(
        uint256 template_id, 
        string calldata question, 
        address arbitrator, 
        uint32 timeout, 
        uint32 opening_ts, 
        uint256 nonce, 
        uint256 tokens
    ) external returns (bytes32) {
        bytes32 questionId = keccak256(abi.encodePacked(question, nonce));
        questions[questionId] = question;
        return questionId;
    }

    function resultFor(bytes32 questionId) external view returns (bytes32) {
        return answers[questionId];
    }

    // Mock function to set the answer for a question
    function setAnswer(bytes32 questionId, bytes32 answer) external {
        answers[questionId] = answer;
    }
}

contract BettingGame_ERC20_Test is Test  {
    BettingGame_ERC20 bettingGame;
    MockERC20 token;
    MockIRealityETH realityETH;
    address player1;
    address player2;
    bytes32 questionId;

    function setUp() public {
        token = new MockERC20();
        realityETH = new MockIRealityETH();
        bettingGame = new BettingGame_ERC20(IRealityETH_ERC20(address(realityETH)), token);
        player1 = address(1);
        player2 = address(2);

        vm.deal(player1, 1 ether);
        vm.deal(player2, 1 ether);

        token.transfer(player1, 1000 * 10 ** 18);
        token.transfer(player2, 1000 * 10 ** 18);

        questionId = keccak256("Will ETH price be above $3000 on 2023-01-01?");
    }

    function testCreateBetERC20() public {
        uint256 betAmount = 100 * 10 ** 18;

        vm.startPrank(player1);
        token.approve(address(bettingGame), betAmount);
        
        bettingGame.createBet("what?", betAmount);
        vm.stopPrank();

        // Check if the bet is created correctly
        // (Add your assertions here)
        assertEq(token.balanceOf(address(bettingGame)), betAmount);
    }

    function testJoinBetERC20() public {
        uint256 betAmount = 100 * 10 ** 18;

        // First, create a bet
        vm.startPrank(player1);
        token.approve(address(bettingGame), betAmount);
        bettingGame.createBet("what?", betAmount);
        vm.stopPrank();

        // Now, join the bet
        vm.startPrank(player2);
        token.approve(address(bettingGame), betAmount);
        bettingGame.joinBet(questionId, betAmount);
        vm.stopPrank();

        // Check if the bet is joined correctly
        // (Add your assertions here)
    }

    function testSettleBetERC20() public {
        uint256 betAmount = 100 * 10 ** 18;

        // Create and join a bet
        vm.startPrank(player1);
        token.approve(address(bettingGame), betAmount);
        bettingGame.createBet("what?", betAmount);
        vm.stopPrank();

        vm.startPrank(player2);
        token.approve(address(bettingGame), betAmount);
        bettingGame.joinBet(questionId, betAmount);
        vm.stopPrank();

        // Set the mock answer in MockIRealityETH
        bytes32 answer = keccak256("Yes");
        realityETH.setAnswer(questionId, answer);

        // Settle the bet
        bettingGame.settleBet(questionId);

        // Check if the bet is settled correctly
        // (Add your assertions here)
    }
}
