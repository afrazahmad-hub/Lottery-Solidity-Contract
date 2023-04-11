// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";


contract Lottary{

    address public manager;

    // Participents of the lottary, participents address must be payable to send receive ethers.
    address payable[] public participents;
    
    constructor (){

        // Particular deployer address will be the Manager of the contract.
        manager = msg.sender;
    }

    // Modifier to set the manager as a owner to call the specific function.
    modifier onlyManager(){
        require(msg.sender == manager, "Only Manager can execute !");
        _;
    }
    // receive function can only be called once in a contract.
    receive() payable external{
        // condition to send a min amount.
        require(msg.value >= 2 ether, "Amount must be grater than 2 ether.");

        // storing the participents in the array.
        participents.push(payable(msg.sender));
    }

        // get the balance of this contract, Only Manager can call it.
    function getBalance() public view onlyManager returns(uint256){
        return address(this).balance;
    }

    // generate a random number
    function randomNum() public view returns(uint){
        // Logic to create a random number.
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, participents))) % participents.length;
    }

    function selectWinner() public onlyManager {
        require(participents.length >= 3, "There should be minimum 3 participants");

        uint index = randomNum();

        address payable winner;
        winner = participents[index];

        // transfer the balance of the contract to the Winner.
        winner.transfer(getBalance());

        // reset the participants arry to 0, for new round.
        participents = new address payable[](0);

       
    }

    // Enter  the addrees of winner account and get the balance.
    function winnerBalance(address winnerAddress) public view returns(uint256){
        return winnerAddress.balance;
    }
}