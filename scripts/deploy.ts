import { ethers } from "hardhat";

async function main() {

    const [owner] = ethers.getSigners();

    const factory = await ethers.getContractFactory("Vulnerable");
    const contract = await factory.deploy();

    await contract.deployed();

    console.log(`Contract deployed TO: ${contract.address}`);
    console.log(`Contract deployed BY: ${owner.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
