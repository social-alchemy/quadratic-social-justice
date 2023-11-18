// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//
//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "forge-std/Test.sol";
//import "../contracts/BettingGame_ERC20.sol";
//import "../contracts/interfaces/IRealityETH_ERC20.sol";
//
//
//contract MockERC20 is ERC20 {
//    constructor() ERC20("MockToken", "MTK") {
//        _mint(msg.sender, 10000 * 10 ** 18);
//    }
//}
//
//contract MockIRealityETH {
//    mapping(bytes32 => bytes32) public answers;
//    mapping(bytes32 => string) public questions;
//    mapping(bytes32 => uint256) public answerTokens;
//
//    // Mock function to simulate asking a question
//    function askQuestionERC20(
//        uint256 template_id,
//        string calldata question,
//        address arbitrator,
//        uint32 timeout,
//        uint32 opening_ts,
//        uint256 nonce,
//        uint256 tokens
//    ) external returns (bytes32) {
//        bytes32 questionId = keccak256(abi.encodePacked(question, nonce));
//        questions[questionId] = question;
//        return questionId;
//    }
//
//        // Mock function to simulate submitting an answer with ERC20 tokens
//    function submitAnswerERC20(
//        bytes32 question_id,
//        bytes32 answer,
//        uint256 max_previous,
//        uint256 tokens
//    ) external {
//        require(tokens > 0, "Token amount must be greater than 0");
//        require(answers[question_id] == 0, "Answer already submitted");
//
//        answers[question_id] = answer;
//        answerTokens[question_id] = tokens;
//    }
//
//    // Function to get the token amount used for an answer
//    function getAnswerTokens(bytes32 question_id) external view returns (uint256) {
//        return answerTokens[question_id];
//    }
//
//    function resultFor(bytes32 questionId) external view returns (bytes32) {
//        return answers[questionId];
//    }
//
//    // Mock function to set the answer for a question
//    function setAnswer(bytes32 questionId, bytes32 answer) external {
//        answers[questionId] = answer;
//    }
//}
//
//contract BettingGame_ERC20_Test is Test  {
//    IBettingGame_ERC20 bettingGame;
//    MockERC20 token;
//    MockIRealityETH realityETH;
//    address player1;
//    address player2;
//    bytes32 questionId;
//
//    function setUp() public {
//        token = new MockERC20();
//        realityETH = new MockIRealityETH();
//        bettingGame = new BettingGame_ERC20(IRealityETH_ERC20(address(realityETH)), token);
//        player1 = address(1);
//        player2 = address(2);
//
//        vm.deal(player1, 1 ether);
//        vm.deal(player2, 1 ether);
//
//        token.transfer(player1, 1000 * 10 ** 18);
//        token.transfer(player2, 1000 * 10 ** 18);
//
//        questionId = keccak256("Will ETH price be above $3000 on 2023-01-01?");
//    }
//
//    function testCreateBetERC20() public {
//        uint256 betAmount = 100 * 10 ** 18;
//
//        vm.startPrank(player1);
//        token.approve(address(bettingGame), betAmount);
//
//        bettingGame.createBet("what?", betAmount);
//        vm.stopPrank();
//
//        assertEq(token.balanceOf(address(bettingGame)), betAmount);
//    }
//
//    function testJoinBetERC20() public {
//        uint256 betAmount = 100 * 10 ** 18;
//
//        // First, create a bet
//        vm.startPrank(player1);
//        token.approve(address(bettingGame), betAmount);
//        bettingGame.createBet("what?", betAmount);
//        vm.stopPrank();
//
//        // Now, join the bet
//        vm.startPrank(player2);
//        token.approve(address(bettingGame), betAmount);
//        bytes32 qId = realityETH.askQuestionERC20(0, "what?", address(bettingGame), 30, uint32(block.timestamp), 0, betAmount);
//        bettingGame.joinBet(qId, betAmount);
//        vm.stopPrank();
//    }
//
//    function testSettleBetERC20() public {
//        uint256 betAmount = 100 * 10 ** 18;
//
//        // Create and join a bet
//        vm.startPrank(player1);
//        token.approve(address(bettingGame), betAmount);
//        bettingGame.createBet("what?", betAmount);
//        vm.stopPrank();
//
//        vm.startPrank(player2);
//        token.approve(address(bettingGame), betAmount);
//        bytes32 qId = realityETH.askQuestionERC20(0, "what?", address(bettingGame), 30, uint32(block.timestamp), 0, betAmount);
//        bettingGame.joinBet(qId, betAmount);
//        vm.stopPrank();
//
//        // Set the mock answer in MockIRealityETH
//        bytes32 answer = keccak256("Yes");
//        realityETH.setAnswer(qId, answer);
//
//        // Settle the bet
//        bettingGame.settleBet(qId);
//
//        // Check if the bet is settled correctly
//        // (Add your assertions here)
//    }
//}
