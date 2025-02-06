//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        //before startBroadcast, not real tx
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        //After startBroadcast, real tx
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed); //constructor FundMe prend une valeur dans ses parenthèses et c'est elle)
        vm.stopBroadcast();
        return fundMe;
    }
}
// Ce script déploie le contrat FundMe sur le réseau courant en utilisant la configuration de flux de prix appropriée.
