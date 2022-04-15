pragma solidity ^0.8.9;

contract DataStorage {
  Data[] public dataSet;

  struct Data{
    string sensorId;
    string timeStamp;
    uint value;
  }

  function addData(string memory Id, string memory time, uint sensorvalue) public {
    dataSet.push(Data(Id, time, sensorvalue));
  }

  function getData(uint pointer) view public returns (string memory Id, string memory time, uint sensorvalue) {
    Id = dataSet[pointer].sensorId;
    time = dataSet[pointer].timeStamp;
    sensorvalue = dataSet[pointer].value;
  }
}
