pragma solidity >=0.7.4 <0.9.0;
contract Token {
    //variable
    uint public totalSupply = 10000 * 10 ** 18;
    string public name = "Test Token";
    string public symbol = "TTK";
    uint public demicals = 18;

    //mapping
    //balances
    mapping(address => uint256) public balances;
    //allowance
    mapping(address => mapping(address => uint256)) public allowance;

    //event

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    //constructor
    constructor(){
        balances[msg.sender] = totalSupply;
    }

    //function: balanceOf
    function balanceOf(address _owner) public view returns (uint256){
        return balances[_owner];

    }

    //function: transfer
    function transfer(address _to, uint256 _value) public returns (bool){
        //check value
        require(_value <= balances[msg.sender],"Balance is too low");
        balances[_to] += _value;
        balances[msg.sender] -= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    //function: transferFrom
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool){
        require(balanceOf(_from) >= _value, "Balance is too low");
        require(allowance[_from][msg.sender] >= _value, "Balance is too low");
        balances[_to] += _value;
        balances[_from] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
        
    }

    //approve
    function approve(address _spender, uint256 _value) public returns (bool){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;

    }

}
