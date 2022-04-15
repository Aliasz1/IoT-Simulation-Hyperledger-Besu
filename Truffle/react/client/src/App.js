import React, { Component } from "react";
import DSContract from "./DataStorage.json";
import getWeb3 from "./getWeb3";

import "./App.css";

class App extends Component {
  state = {storageValue: 0, web3: null, account: null, contract: null };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const account = '0xfe3b557e8fb62b89f4916b721be55ceb828dbd73';

      // Get the contract instance.
      const deployedNetwork = '9077';
      const contractaddress = '0x9a3DBCa554e9f6b9257aAa24010DA8377C57c17e';
      const instance = new web3.eth.Contract(
        DSContract.abi, deployedNetwork && contractaddress,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, account, contract: instance }, this.runExample);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  runExample = async () => {
    const { account, contract } = this.state;

    // Stores a given value, 5 by default.
    //await contract.methods.getData(0).send({ from: account });

    // Get the value from the contract to prove it worked.
    
    const data = await contract.methods.getData(10);
    const response = {
    	sensorId: data.sensorId,
    	timeStamp: data.timeStamp,
    	value: data.value
    };

    // Update state with the result.
    this.setState({ storageValue: response.sensorId });
  };

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, account, and contract...</div>;
    }
    return (
      <div className="App">
        <h1>Good to Go!</h1>
        <p>Your Truffle Box is installed and ready.</p>
        <h2>Smart Contract Example</h2>
        <p>
          If your contracts compiled and migrated successfully, below will show
          a stored value of 5 (by default).
        </p>
        <p>
          Try changing the value stored on <strong>line 42</strong> of App.js.
        </p>
        
        <div>The stored value is: {this.state.storageValue}</div>
      </div>
    );
  }
}

export default App;
