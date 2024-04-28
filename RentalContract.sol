// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RentalContract {
    
    address public owner;
    uint public rent;
    uint public securityDeposit;
    uint public rentDuration;
    uint public contractStart;
    uint public contractEnd;
    address public tenant;
    bool public contractActive;
    
    constructor(uint _rent, uint _securityDeposit, uint _rentDuration) {
        owner = msg.sender;
        rent = _rent;
        securityDeposit = _securityDeposit;
        rentDuration = _rentDuration;
    }
    
    function signContract(address _tenant) public {
        require(msg.sender == owner, "Only owner can sign the contract");
        tenant = _tenant;
        contractStart = block.timestamp;
        contractEnd = block.timestamp + rentDuration;
        contractActive = true;
    }
    
    function payRent() public payable {
        require(msg.sender == tenant, "Only tenant can pay rent");
        require(msg.value == rent, "Rent amount is not correct");
        require(contractActive, "Contract is not active");
    }
    
    function paySecurityDeposit() public payable {
        require(msg.sender == tenant, "Only tenant can pay security deposit");
        require(msg.value == securityDeposit, "Security deposit amount is not correct");
        require(contractActive, "Contract is not active");
    }
    
    function endContract() public {
        require(msg.sender == owner, "Only owner can end the contract");
        contractActive = false;
    }
    
    function withdrawSecurityDeposit() public {
        require(msg.sender == owner, "Only owner can withdraw security deposit");
        require(!contractActive, "Contract is still active");
        payable(owner).transfer(securityDeposit);
    }
    
    function withdrawRent() public {
        require(msg.sender == owner, "Only owner can withdraw rent");
        require(!contractActive, "Contract is still active");
        payable(owner).transfer(rent);
    }
    
    function getContractDetails() public view returns(address, uint, uint, uint, uint, uint, address, bool) {
        return (owner, rent, securityDeposit, rentDuration, contractStart, contractEnd, tenant, contractActive);
    }
    
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function getRentBalance() public view returns(uint) {
        return rent;
    }
    
    function getSecurityDepositBalance() public view returns(uint) {
        return securityDeposit;
    }
    
    function getContractStatus() public 




}