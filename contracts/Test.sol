// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Test{

    string public word1 = "hi1";
    bytes32 public word2 = "hi2";
    bytes2 public word3 = "h3";

    uint8 public number1 = 255;
    uint128 public number2 = 1231231;
    uint256 public number3 = 123123123123;


    address public address1 = 0x2744fE5e7776BCA0AF1CDEAF3bA3d1F5cae515d3;
    bool data = false;
    uint[] public numberlist = [1,2,3];
    string[] public wordList = ["hi1","h2","h3"];

    mapping(string => uint8) public map1;
    mapping(string => bool) public map2;
    
    struct person1{
        string firstName;
        string lastName;
        uint8 age;
    }

    uint8 public number = 244;
    uint64 public bigNumber = 355;

    address public sender;
    address public owner;
    
    modifier onlyOwner(){
        require(owner == msg.sender,'now allowed');
         _;
    }

     constructor (){
        owner = msg.sender;
    }

    function increment () public onlyOwner{
        require(number<244, 'number lower that 244');
        number+=1;
        bigNumber=1;
        sender = msg.sender;
    } 

    uint public balance = address(this).balance;

    function addBalance () public payable onlyOwner{
        balance+= msg.value;
    }

    function setNumber (uint8 _number) public{
        bigNumber = _number;
    }

    function setBig (uint64 _number) public {
        bigNumber = _number;
    }
}