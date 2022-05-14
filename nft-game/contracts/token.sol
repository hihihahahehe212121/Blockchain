pragma solidity ^0.8.1;
import "../node_modules/@OpenZeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@OpenZeppelin/contracts/access/Ownable.sol";
contract  Token is ERC721, Ownable{
    //variables
    struct Pet {
        uint damage; // 0-255 demical 8bit
        uint magic;
        uint lastMeal; //256 bit => 2^256-1
        uint endurance; // 24 hours
    }
    uint256 nextId = 0;

    //mapping

    mapping(uint256 => Pet) private _tokenDetails;

    //event


    //modifier


    //constructor

    constructor(string memory name, string memory symbol) ERC721(name, symbol){

    }

    //function
    function getTokenDetails(uint256 tokenId) public view returns(Pet memory){
        return _tokenDetails[tokenId];

    }

    function mint(uint damage, uint magic, uint256 endurance) public onlyOwner{
        _tokenDetails[nextId] = Pet(damage, magic, block.timestamp, endurance); //set the token before
            _safeMint(msg.sender, nextId); // try get the pet from the token => save mint
        nextId++;
    }

    function feed(uint256 tokenId) public {
        Pet storage pet = _tokenDetails[nextId];
        require(pet.lastMeal + pet.endurance > block.timestamp);
        pet.lastMeal = block.timestamp;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override {
        Pet storage pet = _tokenDetails[nextId];
        require(pet.lastMeal + pet.endurance > block.timestamp); // Pet still alive, if dont have this requre, there are many dead token will be tranfered

    }




}