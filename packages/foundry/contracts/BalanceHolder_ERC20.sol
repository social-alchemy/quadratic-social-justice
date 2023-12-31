// SPDX-License-Identifier: GPL-3.0-only

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import './interfaces/IBalanceHolder_ERC20.sol';

contract BalanceHolder_ERC20 is IBalanceHolder_ERC20 {

    IERC20 public token;

    mapping(address => uint256) public balanceOf;

    event LogWithdraw(
        address indexed user,
        uint256 amount
    );

    function withdraw() 
    public {
        uint256 bal = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        require(token.transfer(msg.sender, bal));
        emit LogWithdraw(msg.sender, bal);
    }

}
