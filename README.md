## NikitaS20 Token Smart Contract

### Overview
The `NikitaS20` smart contract is an ERC20 token implementation using the OpenZeppelin library. This contract introduces additional functionality, such as account freezing and custom transfer functions, to enhance the standard ERC20 behavior.

### Token Details
- **Token Name:** DISNEY
- **Token Symbol:** DN
- **Initial Supply:** 7000 DN 

### Features
1. **Minting Tokens:** Only the contract owner can mint new tokens.
2. **Burning Tokens:** Any user can burn their own tokens, provided their account is not frozen.
3. **Freezing Accounts:** The contract owner can freeze or unfreeze accounts, preventing frozen accounts from transferring tokens.
4. **Custom Transfer Functionality:** Custom transfer functions ensure that frozen accounts cannot transfer tokens.

### Contract Functions

#### Constructor
```solidity
constructor() ERC20("DISNEY", "DN") {
    owner = msg.sender;
    _mint(owner, 7000 );
}
```
Initializes the contract, sets the owner, and mints the initial supply of tokens to the owner.

#### Modifiers
```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not the contract owner");
    _;
}

modifier notFrozen(address account) {
    require(!frozenAccounts[account], "Account is frozen");
    _;
}
```
- `onlyOwner`: Restricts function access to the contract owner.
- `notFrozen`: Ensures that the account is not frozen.

#### Minting Tokens
```solidity
function mintTokens(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
}
```
Allows the contract owner to mint new tokens.

#### Burning Tokens
```solidity
function burnTokens(uint256 amount) public notFrozen(msg.sender) {
    _burn(msg.sender, amount);
}
```
Allows users to burn their own tokens if their account is not frozen.

#### Freezing Accounts
```solidity
function freezeAccount(address account, bool freeze) public onlyOwner {
    frozenAccounts[account] = freeze;
}
```
Enables the contract owner to freeze or unfreeze an account.

#### Checking if an Account is Frozen
```solidity
function isAccountFrozen(address account) public view returns (bool) {
    return frozenAccounts[account];
}
```
Returns the frozen status of an account.

#### Transfer Function
```solidity
function transfer(address recipient, uint256 amount) public override notFrozen(msg.sender) notFrozen(recipient) returns (bool) {
    _transfer(msg.sender, recipient, amount);
    return true;
}
```
Overrides the standard ERC20 `transfer` function to include frozen account checks.

#### Transfer From Function
```solidity
function transferFrom(address sender, address recipient, uint256 amount) public override notFrozen(sender) notFrozen(recipient) returns (bool) {
    _transfer(sender, recipient, amount);
    uint256 currentAllowance = allowance(sender, msg.sender);
    require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
    _approve(sender, msg.sender, currentAllowance - amount);
    return true;
}
```
Overrides the standard ERC20 `transferFrom` function to include frozen account checks.

### License
This project is licensed under the MIT License.
