# Project_BlockChain

## 1. Introduction

This project is a simple implementation of a blockchain.
The objective is a project of a blockchain development DAPP "Young Graduate"

You can find the project [here]("https://github.com/GuillaumeDupuy/Project_BlockChain/blob/main/Ynov-Blockchain_Projet_de_développement_23-24.pdf")

You can see all project in video [here](https://www.youtube.com/watch?v=W6Y606AqyG0)

## 2. Installation

Download the three file solidity and import in [Remix](https://remix.ethereum.org/)
You can also use [Truffle](https://www.trufflesuite.com/) to compile and deploy the smart contract.

## 3. Usage

### 3.1. Smart Contract

## 3.1.1. ERC20Basic.sol

The "ERC20Basic.sol" file defines the basic interface for an ERC20 token contract. It specifies the standard functions for token management, including total supply, balance inquiries, transfers, allowances, and approvals. This interface serves as the foundation for ERC20-compliant tokens, allowing them to be seamlessly integrated into the Ethereum ecosystem.

## 3.1.2. Token.sol

The "Token.sol" file contains the smart contract implementation for an ERC20 token named "YDIPToken." This token features a symbol "YDIP," a name "YDIPToken," and a decimal precision of 15. It provides essential ERC20 functions for token management, including balance inquiries, transfers, allowances, and approvals. Additionally, the file incorporates a SafeMath library to ensure safe arithmetic operations in the contract.

## 3.1.3. Student.sol

The "Student.sol" file contains the implementation of smart contracts for managing student information, including both personal and academic details. It allows for the addition of new students to the registry, storage of their data, and association of academic information, including the diplomas awarded to students.
