const PrivateKeyProvider = require("@truffle/hdwallet-provider");
const privateKey = "0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63";
const privateKeyProvider = new PrivateKeyProvider(privateKey, "http://localhost:8545");

module.exports = {
  networks: {
    besuWallet: {
      provider: privateKeyProvider,
      network_id: "9077",
      chainId: 9077,
      gasPrice: 0,
      gas: "0x1ffffffffffffe",
    },
  },

  compilers: {
    solc: {
      version: "0.8.9",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
};

