const hre = require("hardhat")

async function main(){

    const Storage= await hre.ethers.getContractFactory("ImageStorage");
    const  solAddress= await Storage.deploy();
  
    await solAddress.waitForDeployment();
  
    console.log("deployed address:", await solAddress.getAddress());
  }
  
  main();