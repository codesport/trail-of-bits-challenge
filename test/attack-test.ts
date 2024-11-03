/**
* Hardhat Time Functions:
*   - Get the time (block.timeStamp) in Hardhat Network: await time.latest())
*   - Increase the time in Hardhat Network: await time.increaseTo(unlockTime);
*
* Signing Messages with Ethers.js
*
* @link https://docs.ethers.io/v5/getting-started/#getting-started--signing
*
*/

import { time, loadFixture } from '@nomicfoundation/hardhat-network-helpers'
import { anyValue } from '@nomicfoundation/hardhat-chai-matchers/withArgs'
import { expect } from 'chai'
import { ethers } from 'hardhat'
import { sender, receiver } from '@nomiclabs/hardhat-ethers/signers'

import { Attacker, Victim} from '../typechain-types'

describe('Payment Channel Test', function () {
	let attackContract: Attacker
    let victimContract: Victim

    let attackFactory: any
    let victimFactory: any

	// let sender: string
	// let receiver: string

	beforeEach(async () => {
		;[sender, receiver] = await ethers.getSigners()

        //const [owner, otherAccount] = await ethers.getSigners();

        victimFactory = await ethers.getContractFactory("Victim");
        victimContract = await victimFactory.deploy();
        await victimContract.deployed()

        attackFactory = await ethers.getContractFactory("Attacker");
        attackContract = await attackFactory.deploy( victimContract.address );
        await attackContract.deployed()    

	})

	describe('When Contract is Deployed', function () {

		it('1. Should revert when reading empty winners array', async function () {

            await expect( victimContract.winners(0)).to.be.revertedWithoutReason();
            // console.log( 'Contents of Winners at t = 0 ', await victimContract.winners(0))

			//let attackOne = await attackContract.addWinner( sender.address)

            // console.log( 'Contents of Winners at t = 1 ', await victimContract.winners(0))
		})


		it('2. Should allow addWinner call in attack contract', async function () {

            // console.log( 'Contents of Winners at t = 0 ', await victimContract.winners(0))
            console.log('Test Script: victim\'s address is ', victimContract.address)
			let attackOne = await attackContract.addWinner(sender.address)
            //await expect( attackContract.addWinner( sender.address )).to.be.revertedWithoutReason();

            console.log( 'Test Script: contents of Winners at t = 1 is ', await victimContract.winners(0) )
            console.log( 'Test Script: contents of `target` global:, public state variable is ', await attackContract.target() )
            expect( await victimContract.winners(0)).to.equal( sender.address)


            //let attackTwo = await victimContract.exploit_me( sender.address)

           // console.log( 'Contents of Winners at t = 0 ', await victimContract.winners(0))

            //await expect( victimContract.winners(0)).to.be.revertedWithoutReason();
		})        

	})


    
})