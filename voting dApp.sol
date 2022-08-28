// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Voting
{   
    address payable owner;

    mapping(address => uint) public votecount;

    constructor() {
        owner=payable(msg.sender);
    }

    function vote() public payable
    {
        require(votecount[msg.sender] == 1 , "You can vote only once");
        require(msg.value == 1 ether , "You need to pay 1 ETH to vote");
        votecount[msg.sender]+=1;
    }

    //to show the balance of the contract
    function balance() public view returns(uint)
    {
        require(msg.sender == owner,"You are not authorised");
        return address(this).balance;
    }

    //to withdraw the balance in the contract
    function withdraw() payable public
    {
        owner.transfer(address(this).balance);
    }
}