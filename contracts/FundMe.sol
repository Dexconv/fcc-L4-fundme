// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConvertor.sol";

contract FundMe{
    using PriceConvertor for uint256;
    uint256 public minimumUsd = 50 * 1e18;

    address[] public founders;

    mapping (address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUsd , "not enough sent!"); //1e18 = 1eth
        founders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw ()public onlyOwner {
        for (uint256 i = 0; i < founders.length; i++){
            address founder = founders[i];
            addressToAmountFunded[founder] = 0;
        }
        founders = new address[](0);

        //withdraw the funds

        //automatically revevrts
        //payable(msg.sender).transfer(address(this).balance);

        //returns a bool and should use require to revert
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "send failed!");

        (bool callSuccess,)=payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed!");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "sender is not the owner!");
        _;
    }
    //5:01:13
}
