const express = require ('express');
const cors = require('cors');
const routes = require('./routes');
const Web3 = require('web3');
const contract = require('@truffle/contract');
const artifacts = require('./contracts/artifacts/DataStorage.json');
const CONTACT_ABI = require('./config');
const CONTACT_ADDRESS = require('./config');

var app = express();
app.use(cors());
app.use(express.json());

if (typeof web3 !== 'undefined') {
        var web3 = new Web3(web3.currentProvider); 
} else {
        var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
}

        const accounts = '0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63';
        const contractList = new web3.eth.Contract(CONTACT_ABI.CONTACT_ABI, CONTACT_ADDRESS.CONTACT_ADDRESS);

        routes(app, accounts, contractList);
        app.listen(process.env.PORT || 3001, () => {
                console.log('listening on port '+ (process.env.PORT || 3001));
        });
