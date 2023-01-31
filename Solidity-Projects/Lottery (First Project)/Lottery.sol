//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract Lottery {              //declare 2 variables manager and people
    address public manager;
    address payable[] public people; //multiple-people

    constructor()
    {
        manager=msg.sender; // this is our global variable
    }

    receive()  external payable // can only be used onece, also be used with external
    {
        require(msg.value== 2 ether);
        people.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint)
    {
        require(msg.sender== manager); // amount will be sent and reflected in manager a/c (contract)
        return address(this).balance; //see balance in contract
    }

    function random() public view returns(uint)         //generates a value
    {  // do not use random in professional smart contracts without proper method
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,people.length)));
    }

    function selectWinner() public 
    {
        require((msg.sender== manager));      
        require((people.length>=3));    //min number of participant
        uint r=random(); 
        address payable winner;
        uint index = r % people.length;     // (the remainder wont exceed people.length(index value))
        winner=people[index];   //choooses a index value
        winner.transfer(getBalance());
        people=new address payable[](0); //resets the whole system (index)
    }
}