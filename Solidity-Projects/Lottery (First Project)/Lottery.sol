//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract Lottery {              //declare 2 variables manager and participants
    address public manager;
    address payable[] public participants;

    constructor()
    {
        manager=msg.sender; // this is our global variable
    }

    receive()  external payable // can only be used onece, also be used with external
    {
        participants.push(msg.sender);
    }
}