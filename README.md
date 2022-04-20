# IoT-Simulation-Hyperledger-Besu
Final Year Project 
Device Authentication and Data Privacy for IoT System using a Private Blockchain Network
Project made in Ubuntu 21.04

# Starting Besu
1. open a terminal in the directory of node
2. start the shell file (start.sh)
3. repeat the process for each node

# Importing Node-red
1. open node-red
2. import flow from file
3. select IoT Network.json
4. install the required palettes

palettes used for node-red
1. node-red-contrib-iot-device
2. node-red-node-random

# Truffle
1. set provider in truffle-config.js
2. open terminal in truffle directory
3. enter 'truffle console --network YourNetwork'

# React Interface
1. go to client directory under truffle/react
2. open terminal and enter 'npm run start'
3. go to http://localhost:3000

# Prometheus
1. start terminal in prometheus directory
2. enter 'prometheus --config.file=prometheus.yml' in terminal
3. go to http://localhost:9090