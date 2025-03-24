const PatientRecord = artifacts.require("PatientRecord");

module.exports = async function (deployer) {
  await deployer.deploy(PatientRecord);
  const contract = await PatientRecord.deployed();
  const accounts = await web3.eth.getAccounts();
  // Pre-register some doctors (e.g., accounts[1] and [2])
  await contract.registerDoctor(accounts[1], { from: accounts[0] });
  await contract.registerDoctor(accounts[2], { from: accounts[0] });
};