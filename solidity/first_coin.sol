pragma solidity >= 0.7.0 < 0.9.0;

contract coin{
    //declare minter 
    address public minter;
    mapping(address => uint) public balances; // from address and amount yu can see balances

    event sent(address from, address to, uint amount);

    constructor () {
        minter = msg.sender; //get address of wallet holder
    }
    function mint(address receiver, uint amount) public {
        //correct address
        require(minter==msg.sender);
        require(amount < 1e60);
        balances[receiver]+= amount;
    }
    //send
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Khong co tien bay dat gui");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender,receiver,amount);
    }


}
