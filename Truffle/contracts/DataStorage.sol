pragma solidity ^0.8.9;

contract DataStorage {
  Data[] public dataSet;
  int sensorId;
  string timeStamp;
  int Value;
  
  struct Data{
    int sensorId;
    string timeStamp;
    int value;
  }

  function addData(int id, string memory time, int value) public payable {
    dataSet.push(Data(id, time, value));
  }

  function getData(uint arrayPointer) view public returns (Data memory returnData) {
    returnData = dataSet[arrayPointer];
  }

  function getAllDataBySensor(int givenId) view public returns (Data[] memory returnData){
    uint x = 0;
    for (uint i = 0; i < dataSet.length; i++){
      if (dataSet[i].sensorId == givenId){
        returnData[x] = dataSet[i];
        x++;
      }
    }
  }
}
