# NikitaS20 Token

NikitaS20 is a custom ERC20 token named "DISNEY" with the symbol "DN" built using the OpenZeppelin library. The contract includes functionalities for minting, burning, and freezing accounts.

## Features

- **Minting:** The contract owner can mint new tokens.
- **Burning:** Users can burn their tokens, unless their account is frozen.
- **Freezing Accounts:** The contract owner can freeze and unfreeze accounts.
- **Ownership:** Only the contract owner has special permissions for minting and freezing accounts.

## Contract Overview

### Contract Details

- **Token Name:** DISNEY
- **Token Symbol:** DN
- **Initial Supply:** 7000 DN (allocated to the contract owner)

### Functions

#### Minting Tokens

```solidity
function mintTokens(address to, uint256 amount) public onlyOwner
```

Allows the contract owner to mint new tokens to a specified address.

#### Burning Tokens

```solidity
function burnTokens(uint256 amount) public notFrozen(msg.sender)
```

Allows users to burn their tokens unless their account is frozen.

#### Freezing Accounts

```solidity
function freezeAccount(address account, bool freeze) public onlyOwner
```

Allows the contract owner to freeze or unfreeze an account.

#### Check if Account is Frozen

```solidity
function isAccountFrozen(address account) public view returns (bool)
```

Allows anyone to check if a specific account is frozen.


## Built With

- [OpenZeppelin](https://openzeppelin.com/) - Library for secure smart contract development.
- [Solidity](https://soliditylang.org/) - Programming language for writing smart contracts.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [OpenZeppelin Community](https://forum.openzeppelin.com/) - For providing a comprehensive library for secure smart contract development.


