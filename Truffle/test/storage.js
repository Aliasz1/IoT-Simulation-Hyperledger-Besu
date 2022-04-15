const SimpleStorage = artifacts.require('SimpleStorage.sol');

contract('SimpleStorage', () => {
 it('Should update data', async () => {
  const storage = await SimpleStorage.new('1');
  await storage.setData(10);
  const data = await storage.getData();
  assert(data.toString() == '10');
});
});
