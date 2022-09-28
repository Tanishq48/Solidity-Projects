// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

interface ERC20transfer {
    function transfer(address _to, uint256 _value) external returns (bool success);//for withdrawing tokens tby those 5 accounts
}

contract My721Token is ERC721, Ownable {

    uint NFTsminted=0;

    ERC20transfer public ERC20contractAddress;//address of the erc20 contract wo withdraw tokens

    mapping(uint => address) public NFTowners;
    mapping(address => uint) public numberofNFT;

    constructor() ERC721("my721Token", "M7T") {}

    function safeMint(address to, uint256 tokenId) public onlyOwner { //for minting tokens to 5 different tokens
        require(numberofNFT[to] < 1 ,"Only 1 NFT can be minted for 1 account");
        require(NFTsminted < 5 , "No more NFTs can be minted");
        _safeMint(to, tokenId);
        numberofNFT[to] += 1;
        NFTsminted +=1;
        NFTowners[NFTsminted] = to;
    }

    function updateContractAddress(address contractAddress) public onlyOwner{ 
        ERC20contractAddress = ERC20transfer(contractAddress); //making a variable ERC20transfer(interface used) type
    }

    function withdrawTokens() public payable {
        require(NFTsminted == 5, "All NFT's must be minted first");
        for (uint i = 1; i <= NFTsminted; i++) {
            console.log(NFTowners[i]);
            ERC20transfer(ERC20contractAddress).transfer(NFTowners[i] , 10);
          
        }
    }
}

contract ERC20token is ERC20, Ownable {
    constructor() ERC20("ERC20", "ERC") {
        _mint(msg.sender, 100);
    }
}