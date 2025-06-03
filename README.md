# Attribution

This dApp was created by **Marcos (Marcus) A. B**. His GitHub username is [codesport](https://github.com/codesport). He may be reached through [Code Sport Labs](https://codesport.io/contact-us)

# Learning Modules

Refer to comments in the [Victim](contracts/Victim.sol) and [Attacker](contracts/Attacker.sol)  contracts for detailed notes and tutorials.

Six learning modules for Blockchain development

1. Hardhat Fixtures for Testing Contracts


1.  Reentrancy Attack Mitigation Strategies

    ```
    /* 
    * 1. Place msg.sender.call (i.e., money transfer) after all require checks or after array manipulation 
    *    winners.push(winner);
    *
    * 2. Explicity block non-EOAs via a function modifier, naked require, or error message.
    * @see https://github.com/codesport/blockchain-random-numbers#2-blocking-function-calls-from-smart-contracts-onlyeoas
    *
    */
    ```
1. Calling functions from previoulsy deployed contract (using simulated abstract or castrated contract). Examples: 
   * https://ethereum.stackexchange.com/a/11481/3506 
   * https://blog.chain.link/smart-contract-call-another-smart-contract/
   * https://ethereum.stackexchange.com/a/66257/3506

1. Using Interfaces to call functions in deployed contract: 
    
   *  Example: https://ethereum.stackexchange.com/a/109533/3506

   * Interfaces are limited to what the Contract ABI can represent. The conversion between an ABI and an Interface should be possible without any information loss
   **Source:** https://ethereum.stackexchange.com/a/42459/3506

1. Console logging with Hardhat:
    ```
    /** 
    * Console Logging uses gas, so remove from deployed contracts:
    *
    * https://hardhat.org/hardhat-network/docs/overview#console.log
    * https://hardhat.org/hardhat-runner/docs/getting-started#quick-start
    * https://hardhat.org/hardhat-network/docs/reference#console.log
    *
    * "console.log is implemented in standard Solidity and then detected in Hardhat Network. 
    *  This makes its compilation work with any other tools (like Remix, Waffle or Truffle).
    *  console.log calls can run in other networks, like mainnet, kovan, ropsten, etc. 
    *  They do nothing in those networks, but do spend a minimal amount of gas"
    */
     ```
 
1. Create Repo on GitHub from CLI

   ```
   curl -H "Authorization: token $token" https://api.github.com/user/repos -d '{"name":"reentrancy-attack", "description":"Demonstration and tutorial for reentrancy attack on misplaced call() method", "homepage":"https://codesport.io/blockchain}'
   ```