// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FundingCampaign{

    string public name;
    string public description;
    uint public minContribution;
    mapping (address => bool) public contributer;
    uint public contributerCount;
    address public owner;
    
    modifier onlyOwner(){
        require(owner == msg.sender,'now allowed');
         _;
    }

    struct Request{
        string description;
        uint value;
        address recipient;
        bool completed;
        uint approversCount;
        mapping(address => bool) approvers;
    }
    Request[] public request; 

    constructor(string memory _name, string memory _description, uint8 _minContribution){
        owner = msg.sender;
        name = _name;
        description = _description;
        minContribution = _minContribution;
    }

    function contribute() public payable{
        require(msg.value >= minContribution, 'not min value!');
        contributer[msg.sender] = true;
        contributerCount++;
    }

    function createRequest(string calldata _description, uint _value, address _recipient) public onlyOwner{
        Request storage newRequest = request.push();
        newRequest.description = _description;
        newRequest.value = _value;
        newRequest.recipient = _recipient;
        newRequest.completed = false;
        newRequest.approversCount = 0;
    }

    function approveRequest(uint _index) public {
        require(contributer[msg.sender], 'not funder');
        Request storage cRequest = request[_index];
        require(cRequest.approvers[msg.sender] == false && cRequest.completed == false,"already approved");
        cRequest.approvers[msg.sender] = true;
        cRequest.approversCount++;
    }

    function finalizeRequest(uint _index) public onlyOwner {
        Request storage cRequest = request[_index];
        require(!cRequest.completed, 'already completed');
        require(cRequest.approversCount > contributerCount/2, 'not enough approve');
        cRequest.completed = true;
        payable(cRequest.recipient).transfer(cRequest.value);
    }
}