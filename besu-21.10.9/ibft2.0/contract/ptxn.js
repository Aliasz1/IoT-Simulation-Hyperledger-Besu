const path = require('path');
const fs = require('fs-extra');
Web3 = require('web3');

const web3 = new Web3( new Web3.providers.HttpProvider("http://127.0.0.1:8545"));
// use the existing Member1 account address or make a new account
const address = "0x1da1c69ead32dfc5c5339ed3c8ca2005feef804913d824ef02d8b0e3ff57629b";

// read in the contracts
const contractJsonPath = path.resolve(__dirname, 'SimpleStorage.json');
const contractJson = JSON.parse(fs.readFileSync(contractJsonPath));
const contractAbi = contractJson.abi;
const contractBinPath = path.resolve(__dirname, 'SimpleStorage.bin');
const contractByteCode = JSON.parse(fs.readFileSync(contractJsonPath));

async function createContract(host, contractAbi, contractByteCode, contractInit, fromAddress) {
  const web3 = new Web3(host)
  const contractInstance = new web3.eth.Contract(contractAbi);
  const ci = await contractInstance
    .deploy({ data: '0x'+contractByteCode, arguments: [contractInit] })
    .send({ from: fromAddress, gasLimit: "0x24A22" })
    .on('transactionHash', function(hash){
      console.log("The transaction hash is: " + hash);
    });
  return ci;
};

// create the contract
async function main(){
  // using Member1 to send the transaction from
  createContract("http://localhost:8545", contractAbi, contractByteCode, 47, address)
  .then(async function(ci){
    console.log("Address of transaction: ", ci.options.address);
  })
.catch(console.error);

}
