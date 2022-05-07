pragma solidity >= 0.7.0 < 0.9.0;
contract game {
    uint public count = 0;
    mapping(address => Player) public players;
    enum Level {Beginner,Intermediate,Avande}

    struct Player {
        address addressPlayer;
        string name;
        Level myLevel;
        uint createTime;
    }
    //addPlayer
    function addPlayer (string memory name) public{
        players[msg.sender] = Player(msg.sender,name,Level.Beginner,block.timestamp);
        count+=1;
    }
    //getPlayerLevel
    function getPlayerLevel (address addressPlayer) public view returns (Level){
        return players[addressPlayer].myLevel;
    }
    //changePlayerLevel
    function changePlayerLevel (address addressPlayer) public {
        Player storage player = players[addressPlayer]; //storage: allocate memory
        if(block.timestamp >= player.createTime + 30) {
            player.myLevel = Level.Intermediate;
        }
    }
}   