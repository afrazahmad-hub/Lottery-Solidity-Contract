import { task } from "hardhat/config";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { ethers } from "hardhat";

task(
  "acounts",
  "It will show the list of accounts",
  async (taskArgs: any, hre: any) => {
    const accounts = await hre.ethers.getsigner();

    for (const account of accounts) {
      const address = await account.getAddress();
      const balance = await account.getBalance();

      console.log(`Address: ${address}, Balance: ${balance}`);
    }
  }
);

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  defaultNetwork: "goerli",
  networks: {
    hardhat: {},
    goerli: {
      url: "https://goerli.infura.io/v3/7c02737cf5f14c60899538534507f28c",
      accounts: [
        "e38f16732ae8363d931591061d2b36337c5778c45fa016aea283b2b632fdab0f",
      ],
    },
  },
};

export default config;
