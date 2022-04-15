Web3 = require('web3');

const web3 = new Web3( new Web3.providers.HttpProvider("http://127.0.0.1:8545"));
// use an existing account, or make an account
const privateKey = "0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63";
const account = web3.eth.accounts.privateKeyToAccount(privateKey);

// read in the contracts
const contractJson = 'SimpleStorage.json';
const contractAbi = contractJson.abi;
const contractBin = 'SimpleStorage.bin';
// initialize the default constructor with a value `47 = 0x2F`; this value is appended to the bytecode
const contractConstructorInit = "000000000000000000000000000000000000000000000000000000000000002F";

// get txnCount for the nonce value
const txnCount = web3.eth.getTransactionCount(account.address);

const rawTxOptions = {
  nonce: 0x0,
  from: account.address,
  to: null, //public tx
  value: "0x00",
  data: '0x'+contractBin+contractConstructorInit, // contract binary appended with initialization value
  gasPrice: "0x0", //ETH per unit of gas
  gasLimit: "0x24A22" //max number of gas units the tx is allowed to use
};
console.log("Creating transaction...");
const tx = new Tx(rawTxOptions);
console.log("Signing transaction...");
tx.sign(privateKey);
console.log("Sending transaction...");
var serializedTx = tx.serialize();
const pTx = web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex').toString("hex"));
console.log("tx transactionHash: " + pTx.transactionHash);
console.log("tx contractAddress: " + pTx.contractAddress);
