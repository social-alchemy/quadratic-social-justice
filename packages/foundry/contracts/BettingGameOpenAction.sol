// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {HubRestricted} from 'lens/HubRestricted.sol';
import {Types} from 'lens/Types.sol';
import {IPublicationActionModule} from './interfaces/IPublicationActionModule.sol';
import {IBettingGame} from './interfaces/IBettingGame.sol';

contract BettingGameOpenAction is HubRestricted, IPublicationActionModule {
    mapping(uint256 profileId => mapping(uint256 pubId => string initMessage)) internal _initMessages;
    IBettingGame internal _bettingGame;
    
    constructor(address lensHubProxyContract, address bettingGameContract) HubRestricted(lensHubProxyContract) {
        _bettingGame = IBettingGame(bettingGameContract);
    }

    // called when the publication using this action is being published, 
    // its purpose is to initialize any state that the publication action module may require.
    function initializePublicationAction(
        uint256 profileId,
        uint256 pubId,
        address /* transactionExecutor */,
        bytes calldata data
    ) external override onlyHub returns (bytes memory) {
        string memory initMessage = abi.decode(data, (string));

        _initMessages[profileId][pubId] = initMessage;
        
        // === 4 step === 
        // 1. create bet
        // 2. place bet
        // 3. set result
        // 4. withdraw

        return data;
    }

    // called when the action is triggered by some profile, 
    // it purpose is to execute the action itself, so it should contain the logic of it.
    function processPublicationAction(
        /**
         *  
         *     
         enum PublicationType {
            Nonexistent,
            Post,
            Comment,
            Mirror,
            Quote
        }
         struct ProcessActionParams {
            uint256 publicationActedProfileId;
            uint256 publicationActedId;
            uint256 actorProfileId;
            address actorProfileOwner;
            address transactionExecutor;
            uint256[] referrerProfileIds;
            uint256[] referrerPubIds;
            Types.PublicationType[] referrerPubTypes;
            bytes actionModuleData;
        }
         */
        Types.ProcessActionParams calldata params
    ) external override onlyHub returns (bytes memory) {
        string memory initMessage = _initMessages[params.publicationActedProfileId][params.publicationActedId];
        // params.transactionExecutor
        (string memory actionMessage) = abi.decode(params.actionModuleData, (string));
        
        return "";
    }
}