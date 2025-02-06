# FundMe Smart Contract Project

This project contains a collection of Solidity contracts, deployment scripts, interaction scripts, and tests for a simple crowdfunding smart contract called **FundMe**. The **FundMe** contract accepts ETH contributions, verifies that each contribution meets a minimum USD threshold (using a Chainlink price feed), and allows the contract owner to withdraw the collected funds.

## Table of Contents
- [FundMe Smart Contract Project](#fundme-smart-contract-project)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Contracts Overview](#contracts-overview)
    - [FundMe.sol](#fundmesol)
    - [PriceConverter.sol](#priceconvertersol)
    - [DeployFundMe.s.sol](#deployfundmessol)
    - [HelperConfig.s.sol](#helperconfigssol)
    - [Interactions.s.sol](#interactionsssol)
    - [MockV3Aggregator.sol](#mockv3aggregatorsol)
  - [Testing](#testing)
    - [FundMeTest.t.sol](#fundmetesttsol)

## Overview

The **FundMe** contract is designed to:
- Accept contributions in ETH.
- Verify that each contribution meets a specified minimum amount in USD using Chainlink price feeds.
- Track contributors and their funded amounts.
- Allow only the contract owner to withdraw the collected funds.

This project is built with [Foundry](https://book.getfoundry.sh/) and includes scripts for deployment and interaction with the contract.

## Contracts Overview

### FundMe.sol
- **Purpose:**  
  The main smart contract that manages funding. It accepts ETH contributions (after verifying the USD value), records each contributor's contribution, and provides functions for the owner to withdraw the funds.
- **Key Functions:**  
  - `fund()`: Accepts contributions if the converted USD value is above the minimum threshold.
  - `withdraw()` / `cheaperWithdraw()`: Allow the owner to withdraw the funds.
  - Fallback and receive functions to handle direct ETH transfers.

### PriceConverter.sol
- **Purpose:**  
  A library that provides utility functions to convert ETH amounts into USD using a Chainlink price feed.
- **Key Functions:**  
  - `getPrice()`: Retrieves the current ETH/USD price.
  - `getConversionRate()`: Converts an ETH amount to its USD equivalent.

### DeployFundMe.s.sol
- **Purpose:**  
  A deployment script that deploys the **FundMe** contract to the target network. It uses the configuration provided by **HelperConfig** to determine the correct price feed address.

### HelperConfig.s.sol
- **Purpose:**  
  Provides network configuration by returning the correct price feed address for live networks (e.g., Sepolia, Mainnet) or by deploying a mock price feed when running on a local network (e.g., Anvil).

### Interactions.s.sol
- **Purpose:**  
  Contains scripts for interacting with an already deployed **FundMe** contract.
- **Components:**
  - **FundFundMe:** Sends 1 ETH to the **FundMe** contract by calling its `fund()` function.
  - **WithdrawFundMe:** Calls the `withdraw()` function on the **FundMe** contract to withdraw the funds.

### MockV3Aggregator.sol
- **Purpose:**  
  A mock implementation of a Chainlink price feed used for testing purposes in local environments.

## Testing

### FundMeTest.t.sol
- **Purpose:**  
  Unit tests that validate the internal logic of the **FundMe** contract. These tests ensure that funding, data updates, and withdrawal restrictions work as expected.
- **Run Tests:**  
  Execute with:
  ```bash
  forge test
