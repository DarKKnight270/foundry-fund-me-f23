// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;
    address USER = makeAddr("jad");
    uint256 constant SEND_VALUE = 1 ether;
    uint256 constant STARTING_BALANCE = 100 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteraction() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
// Ce test d'intégration simule des interactions réelles avec le contrat FundMe pour vérifier le bon fonctionnement de la collecte de fonds.
//est un fichier de tests d'intégration qui simule des scénarios d'interaction avec le contrat afin de vérifier que celui-ci se comporte correctement dans différents cas de figure.

//InteractionsTest.t.sol est un test d'intégration qui simule un scénario complet. Dans ce test,
//on déploie le contrat FundMe (via le script de déploiement), puis on utilise les fonctions des scripts d'interaction
//(c'est-à-dire les fonctions de FundFundMe et WithdrawFundMe définies dans Interactions.s.sol) pour financer le contrat
//et ensuite retirer les fonds. À la fin, le test vérifie que le solde du contrat est bien égal à zéro.
