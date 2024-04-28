// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract trial{
address private owner;
uint monthlyRent;
constructor(uint _rent) {
        owner = msg.sender;
        monthlyRent=_rent;
    }
function rentMoney() public payable{

require(msg.value>=monthlyRent, "Rent amount is not correct");


}

}