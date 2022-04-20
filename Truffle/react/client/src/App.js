import React, { Component } from "react";
import DSContract from "./DataStorage.json";
import getWeb3 from "./getWeb3";
import moment from 'moment';

import "./App.css";

class App extends Component {
  state = {storageValue: 0, getId: 0, getTime: 0, web3: null, account: null, contract: null, getValue: 0 };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const account = '0xFE3B557E8Fb62b89F4916B721be55cEb828dBd73';

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
    const contract = this.state.contract;
    
    const data = await contract.methods.getData(0).call();
    const response = {
    	sensorId: data.sensorId,
    	timeStamp: data.timeStamp,
    	value: data.value
    };
    moment().format();
    var time = moment.unix(response.timeStamp);
    time = time.toString();

    // Update state with the result.
        this.setState({ getId: response.sensorId });
    	this.setState({ getTime: time });
    	this.setState({ storageValue: response.value });
  };
  
  constructor(props){
	super(props);

	this.updateInput = this.updateInput.bind(this);
	this.handleSubmit = this.handleSubmit.bind(this);
	};

  updateInput(event){
	this.setState({getValue : event.target.value})
	};

  handleSubmit = async () => {
  	const contract = this.state.contract;

  	const data = await contract.methods.getData(this.state.getValue).call();
    	const response = {
    		sensorId: data.sensorId,
    		timeStamp: data.timeStamp,
    		value: data.value
    	};
    	
    	moment().format();
    	var time = moment.unix(response.timeStamp);
    	time = time.toString();
    	this.setState({ getId: response.sensorId });
    	this.setState({ getTime: time });
    	this.setState({ storageValue: response.value });
	};

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, account, and contract...</div>;
    }
    return (
      <div className="App">
        <h1>ReactJS Interface</h1>
        <p>Account connected: {this.state.account}</p>
        <br></br>
        <h2>Data Storage Contract</h2>
        
        <div>
        <p>Enter number to get from array</p>
		<input type="number" onChange={this.updateInput}></input>
    		<input type="submit" onClick={this.handleSubmit}></input>
      	</div>
        
        <div>
        <p>The sensor id is: {this.state.getId}</p>
        <p>The time sent is: {this.state.getTime}</p>
	<p>The stored value is: {this.state.storageValue}</p>
        </div>
      </div>
    );
  }
}

export default App;
