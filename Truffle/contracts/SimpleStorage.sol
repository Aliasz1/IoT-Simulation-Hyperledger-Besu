pragma solidity ^0.8.9;

contract SimpleStorage {
  uint public storedData;

  function setData(uint x) public {
    storedData = x;
  }

  function getData() view public returns (uint retVal) {
    return storedData;
  }
}
