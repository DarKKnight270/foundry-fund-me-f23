//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
//Fund
//Withdraw

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 1 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

// Ce script interagit avec le contrat FundMe en envoyant 1 ether via la fonction fund(), ciblant le déploiement le plus récent.
// Ce squelette de script est destiné à automatiser le retrait des fonds du contrat FundMe (implémentation à compléter).
//est un script destiné à interagir en direct avec le contrat déployé (par exemple, en finançant ou retirant des fonds),
//utilisé dans un contexte de déploiement ou d'opérations sur le réseau.

//Interactions.s.sol est un script d'interaction. Il définit des fonctions concrètes pour agir sur le contrat FundMe déployé.
//Par exemple, le script FundFundMe envoie 1 ether au contrat en appelant sa fonction fund(), et le script WithdrawFundMe appelle
//la fonction withdraw() pour retirer les fonds. Ces scripts sont conçus pour être exécutés sur le réseau (ou en environnement simulé)
//pour automatiser des actions sur le contrat.
