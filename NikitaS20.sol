// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NikitaS20 is ERC20 
{
    address public owner;
    mapping(address => bool) private frozenAccounts;

    constructor() ERC20("DISNEY", "DN")
    {
        owner = msg.sender;
        _mint(owner, 7000*10**decimals());
    }

    modifier onlyOwner() 
    {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier notFrozen(address account) 
    {
        require(!frozenAccounts[account], "Account is frozen");
        _;
    }

    function mintTokens(address to, uint256 amount) public onlyOwner 
    {
        _mint(to, amount);
    }

    function burnTokens(uint256 amount) public notFrozen(msg.sender)
    {
        _burn(msg.sender, amount);
    }

    function freezeAccount(address account, bool freeze) public onlyOwner 
    {
        frozenAccounts[account] = freeze;
    }

    function isAccountFrozen(address account) public view returns (bool) 
    {
        return frozenAccounts[account];
    }

    function transfer(address recipient, uint256 amount) public override notFrozen(msg.sender) notFrozen(recipient) returns (bool) 
    {
        return super.transfer(recipient, amount);
    }
}
