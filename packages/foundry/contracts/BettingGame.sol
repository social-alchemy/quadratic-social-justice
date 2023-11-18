pragma solidity ^0.8.0;

import "./interfaces/IRealityETH.sol";

contract BettingGame {
    IRealityETH public realityETH;
    address public owner;
    mapping(bytes32 => Bet) public bets;

    struct Bet {
        address payable player1;
        address payable player2;
        uint256 amount;
        bytes32 questionId;
        bool isSettled;
    }

    event BetPlaced(
        bytes32 indexed betId, address indexed player1, address indexed player2, uint256 amount, bytes32 questionId
    );
    event BetSettled(bytes32 indexed betId, address winner);

    constructor(address _realityETH) {
        realityETH = IRealityETH(_realityETH);
        owner = msg.sender;
    }

    function createBet(string memory question, address arbitrator, uint32 timeout, uint32 opening_ts, uint256 nonce)
        external
        payable
        returns (bytes32)
    {
        bytes32 questionId =
            realityETH.askQuestion{value: msg.value}(0, question, arbitrator, timeout, opening_ts, nonce);
        Bet memory newBet = Bet({
            player1: payable(msg.sender),
            player2: payable(address(0)),
            amount: msg.value,
            questionId: questionId,
            isSettled: false
        });
        bets[questionId] = newBet;
        emit BetPlaced(questionId, msg.sender, address(0), msg.value, questionId);
        return questionId;
    }

    function joinBet(bytes32 betId) external payable {
        Bet storage bet = bets[betId];
        require(bet.player2 == address(0), "Bet already has two players");
        require(msg.value == bet.amount, "Bet amount must match");
        bet.player2 = payable(msg.sender);
    }

    function settleBet(bytes32 betId) external {
        Bet storage bet = bets[betId];
        require(!bet.isSettled, "Bet is already settled");
        bytes32 answer = realityETH.resultFor(bet.questionId);
        address winner;
        // Assuming the answer is either 0 or 1
        if (answer == bytes32(uint256(1))) {
            winner = bet.player1;
        } else {
            winner = bet.player2;
        }
        bet.isSettled = true;
        (bool sent,) = payable(winner).call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
        emit BetSettled(betId, winner);
    }
}
