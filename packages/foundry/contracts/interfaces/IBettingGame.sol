pragma solidity ^0.8.0;

interface IBettingGame {
    function createBet(string memory question, address arbitrator, uint32 timeout, uint32 opening_ts, uint256 nonce)
        external
        payable
        returns (bytes32);

    function joinBet(bytes32 betId) external payable;

    function settleBet(bytes32 betId) external;
}
