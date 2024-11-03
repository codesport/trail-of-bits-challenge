// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// The goal of this challenge is to be able to sign offchain a message
// with an address stored in winners.

import "hardhat/console.sol";

contract Victim{

    address[] public winners;
    bool public lock;

    function exploit_me(address winner) public{

        console.log("Victim Contract: call to exploit_me from Attacker");
        console.log("Victim Contract: my address is %s ", address(this) );
        console.log('Victim Contract: I see tx.orgin as %s', tx.origin);

        lock = false;

        // call() method will invoke the fallback function
        // call only returns a bool.  Returns false if the call encounters an exception
        // This is a bad and forced implementation. Only use when sending ether
         msg.sender.call("");

        require(lock);
        winners.push(winner);
    }

    function lock_me() public{
        console.log("Victim Contract: call to lock_me() from Attacker");
        lock = true;
    }
}


/**
 * Mitigation strategy:
 * 
 * NB: msg.sender.call("") is usually msg.sender.call{value: eth_amount}("")
 *     The shortened version in this challenge is a synonym for the full version 
 *  
 * 1. Place msg.sender.call("") after require(lock) or after array manipulation 
 *    winners.push(winner);
 *
 * 2. Explicity block non-EOAs via a function modifier, naked require, or 
 *    error message.
 * @see https://github.com/codesport/blockchain-random-numbers#2-blocking-function-calls-from-smart-contracts-onlyeoas
 *
 */

// https://ethereum.stackexchange.com/a/109682/3506
// We can always be sure that tx.origin is an externally owned account! 
// tx.origin is the original sender of the call. In a transaction that 
// results in a chain of calls, tx.origin is the EOA that initiated the transaction
//  in the first place (contracts cant initiate transactions on their own) and 
//  msg.sender is the last member of the chain (and it can be a contract)