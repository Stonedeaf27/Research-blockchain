//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

contract crowdFunding{      //defining variables
    mapping(address=>uint) public contributors;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public numContributors;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint numVoters;
        mapping(address=>bool) voters;
    }

    mapping(uint=>Request) public requests;
    uint public numRequests;
    constructor(uint _target,uint _deadline){       
        target=_target;
        deadline=block.timestamp+_deadline;     //block.timestamp - global variable // 10sec + 3600sec (for 1 hour)
        minimumContribution = 1 ether;
        manager=msg.sender;
    }

    function sendETH() public payable{      // if condition not met it will throw an msg
        require(block.timestamp < deadline,"Deadline has passed");
        require(msg.value >= minimumContribution,"Minimum contribution needed (1 ether)");

        if(contributors[msg.sender]==0){
            numContributors++;      //diff contributor ( we will find perecntage on basis of diff contributor)
        }
        contributors[msg.sender]+= msg.value;
        raisedAmount+=msg.value;            //contribution is increased
    }
    function getContractBalance() public view returns(uint){    //to check balance in contract
        return address(this).balance;   //returns balance
    }
    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target, "Condition not met, Not eligible for Refund");
        require(contributors[msg.sender]>0);
        address payable user=payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;
    }

    modifier onlyManager()
    {
        require(msg.sender==manager, "Only Manager can call this function");
        
    }
    function createRequests(string memory _description, address payable _recipient, uint _value) public onlyManager{
        Request storage newRequest = requests[numRequests];
    }
}