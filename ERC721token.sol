// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract GoodMonk is ERC721, Ownable{

    uint256 totalsupply=1000;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    constructor() ERC721("GoodMonk", "GMK") {}
    //name of the token is GoodMonk & symbol is GMK

    //function to safely mint tokens
    function _safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId < totalsupply, "No tokens left to be minted");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}