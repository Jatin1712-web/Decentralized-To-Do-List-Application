async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying DecentralizedTodo contract with account:", deployer.address);

  const DecentralizedTodo = await ethers.getContractFactory("DecentralizedTodo");
  const decentralizedTodo = await DecentralizedTodo.deploy();

  await decentralizedTodo.deployed();

  console.log("DecentralizedTodo deployed to:", decentralizedTodo.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
