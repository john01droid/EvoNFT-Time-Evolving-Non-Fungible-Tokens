const hre = require("hardhat");

async function main() {
  const EvoNFT = await hre.ethers.getContractFactory("EvoNFT");
  const evoNFT = await EvoNFT.deploy();

  await evoNFT.deployed();
  console.log("EvoNFT contract deployed to:", evoNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error deploying EvoNFT:", error);
    process.exit(1);
  });
