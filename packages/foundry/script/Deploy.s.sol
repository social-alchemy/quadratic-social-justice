//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import "../contracts/interfaces/IRealityETH_ERC20.sol";
import "../contracts/RealityETH_ERC20.sol";
import "../contracts/RealityETH_v3_0.sol";
import "../contracts/BettingGameOpenAction.sol";
import "../contracts/interfaces/IBettingGame.sol";
import "../contracts/interfaces/IBettingGame_ERC20.sol";
import "../contracts/BettingGame_ERC20.sol";

import "../contracts/BettingGame.sol";


import "./DeployHelpers.s.sol";


// forge script script/Deployer.s.sol:TreasureDeployer --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast -vvvv
contract Deployer is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    RealityETH_ERC20 public realityAddress;
    BettingGame_ERC20 public gameErc20Address;
    BettingGameOpenAction public bgoaAddress;

    IERC20 public tokenAddress = IERC20(address(0));

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        realityAddress = new RealityETH_ERC20();
        console.logString(string.concat("RealityETH_ERC20_v3_0 deployed at: ", vm.toString(address(realityAddress))));

        IRealityETH_ERC20 realityErc20Address = IRealityETH_ERC20(address(realityAddress));
        gameErc20Address = new BettingGame_ERC20(realityErc20Address, tokenAddress);
        console.logString(string.concat("BettingGame deployed at: ", vm.toString(address(gameErc20Address))));

        // address lensHubProxyContract, address _bettingGameContract, address _realityETH, IERC20 _tokenAddress
        bgoaAddress = new BettingGameOpenAction(
            address(0),
            address(gameErc20Address),
            address(realityErc20Address),
            tokenAddress
        );
        console.logString(string.concat("BettingGameOpenAction deployed at: ", vm.toString(address(bgoaAddress))));

        vm.stopBroadcast();
        exportDeployments();
    }
}
