// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IRealityETH_ERC20.sol"; // Assuming IRealityETH is the interface based on the provided ABI

contract BettingGame_ERC20 {
    IRealityETH_ERC20 public realityETH;
    IERC20 public token;

    struct Bet {
        bytes32 questionId;
        uint256 amount;
        address better;
        bool isSettled;
    }

    mapping(bytes32 => Bet) public bets;

    event BetPlaced(bytes32 indexed questionId, address indexed better, uint256 amount);
    event BetSettled(bytes32 indexed questionId, address indexed winner, uint256 amount);

    constructor(IRealityETH_ERC20 _realityETH, IERC20 _token) {
        realityETH = _realityETH;
        token = _token;
    }

    function createBet(string memory question, uint256 amount) public {
        require(token.allowance(msg.sender, address(this)) >= amount, "Insufficient token allowance");
        token.transferFrom(msg.sender, address(this), amount);

        bytes32 questionId = realityETH.askQuestionERC20(0, question, address(this), 30, uint32(block.timestamp), 0, amount);
        bets[questionId] = Bet(questionId, amount, msg.sender, false);

        emit BetPlaced(questionId, msg.sender, amount);
    }

    function joinBet(bytes32 questionId, uint256 amount) public {
        Bet storage bet = bets[questionId];
        require(bet.amount == amount, "Bet amount mismatch");
        require(token.allowance(msg.sender, address(this)) >= amount, "Insufficient token allowance");

        token.transferFrom(msg.sender, address(this), amount);
        realityETH.submitAnswerERC20(questionId, bytes32(0), 0, amount); // Assuming 0 is a placeholder answer
    }

    function settleBet(bytes32 questionId) public {
        Bet storage bet = bets[questionId];
        require(!bet.isSettled, "Bet already settled");

        bytes32 answer = realityETH.resultFor(questionId);
        address winner = answer == bytes32(uint256(1)) ? bet.better : msg.sender; // Assuming 1 represents a correct answer

        bet.isSettled = true;
        token.transfer(winner, bet.amount * 2);

        emit BetSettled(questionId, winner, bet.amount * 2);
    }
}
