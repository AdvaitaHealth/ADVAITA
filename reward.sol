// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

/*
The function of contract is to send token when get a valid report hash
And per report would be rewarded once
*/

contract Reward {

    //a map to store info if the user has been rewarded
    mapping(string => bool) public user_is_reward;
    

    //need a public account to maintain the balance of contract：API implement
    //send token to contract before a user can attain reward token
    function add_reward_to_pool() public payable {
        require(msg.value > 10 ether,"The amount sent to the contract each time cannot be less than 10 eth");
    }

    //get contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    //params:report hash, public address 
    function reward(string memory user, address payable public_address) public {

        //verify hash 
        require(bytes(user).length >0,"invalid report hash, please check it again");

        //duplicate reward varify
        require(user_is_reward[user]== false,"the report hash has been used,please try another one ");
        
        //reward conditions 
        require(address(this).balance > 1 ether,
            "The balance of the contract account is insufficient, please send some token to contract");
        public_address.transfer(1 ether);  
        //set report reward status 
        user_is_reward[user] = true;
    }
}
