pragma solidity >= 0.7.0 < 0.9.0;

contract coin{
    //declare minter 
    address public minter;
    mapping(address => uint) public balances; // from address and amount yu can see balances

    event sent(address from, address to, uint amount);

    //check minter
    modifier onlyMinter(address receiver){
        require(msg.sender == receiver);
        _;
    }
    //checkamount
    modifier checkAmount(uint amount){
        require(amount < 1e60);
        _;
    }

    //checkbalance
    modifier checkBalance(uint amount){
        require(amount <= balances[msg.sender],"khong co tien bay dat gui");
        _;
    }

    constructor () {
        minter = msg.sender; //get address of wallet holder
    }
    function mint(address receiver, uint amount) public onlyMinter(receiver) checkAmount(amount){
        //correct address
        //require(minter == msg.sender); => modifier
        //require(amount < 1e60); => modifier
        balances[receiver]+= amount;
    }
    //send
    function send(address receiver, uint amount) public checkBalance(amount){
        //require(amount <= balances[msg.sender], "Khong co tien bay dat gui"); => modifier
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender,receiver,amount);
    }


}
