// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {HubRestricted} from 'lens/HubRestricted.sol';
import {Types} from 'lens/Types.sol';
import {IPublicationActionModule} from './interfaces/IPublicationActionModule.sol';
import {IBettingGame_ERC20} from './interfaces/IBettingGame_ERC20.sol';
import {IRealityETH_ERC20} from './interfaces/IRealityETH_ERC20.sol';


contract BettingGameOpenAction is HubRestricted, IPublicationActionModule {
    struct InitMessage {
       uint256 stakingAmount;
       bytes betOnWhat;
    }
    mapping(uint256 profileId => mapping(uint256 pubId => InitMessage)) public initMessageList;
    IBettingGame_ERC20 internal bettingGame;
    IRealityETH_ERC20 internal realityETH;
    IERC20 public tokenAddress;

    constructor(address lensHubProxyContract, address _bettingGameContract, address _realityETH, IERC20 _tokenAddress) HubRestricted(lensHubProxyContract) {
        bettingGame = IBettingGame_ERC20(_bettingGameContract);
        realityETH = IRealityETH_ERC20(_realityETH);
        tokenAddress = _tokenAddress;
    }

    function initializePublicationAction(
        uint256 profileId,
        uint256 pubId,
        address,
        bytes calldata data
    ) external override onlyHub returns (bytes memory) {
        (bytes memory profile, bytes memory betOnWhat, uint256 stakingAmount, uint32 deadline) = abi.decode(data, (bytes, bytes, uint256, uint32));
        initMessageList[profileId][pubId] = InitMessage({
            stakingAmount: stakingAmount,
            betOnWhat: betOnWhat
        });
        bettingGame.createBet(string(betOnWhat), stakingAmount);
        return data;
    }

    function processPublicationAction(Types.ProcessActionParams calldata params) external override onlyHub returns (bytes memory) {
        InitMessage memory initMessage = initMessageList[params.publicationActedProfileId][params.publicationActedId];
        (string memory actionMessage) = abi.decode(params.actionModuleData, (string));

         // 2. place bet
         tokenAddress.approve(address(bettingGame), uint256(initMessage.stakingAmount));
         // function askQuestionERC20 (uint256 template_id, string calldata question, address arbitrator, uint32 timeout, uint32 opening_ts, uint256 nonce, uint256 tokens) external returns (bytes32);
         bytes32 qId = realityETH.askQuestionERC20(0, string(initMessage.betOnWhat), address(bettingGame), 30, uint32(block.timestamp), 0, initMessage.stakingAmount);
         bettingGame.joinBet(bytes32(params.publicationActedProfileId), initMessage.stakingAmount);
         // 3. set result
         // bytes32 answer = keccak256("Yes");
         // realityETH.setAnswer(qId, answer);

        // 4. withdraw
        // bettingGame.settleBet(qId);
        return "";
   }
}
