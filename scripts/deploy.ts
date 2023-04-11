import { ethers } from "hardhat";
const hre = require("hardhat");

async function main() {
  const Lottery = await hre.ethers.getContractFactory("Lottary");
  const lottery = await Lottery.deploy();

  await lottery.deployed();

  console.log(`Contract Addres: ${lottery.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
