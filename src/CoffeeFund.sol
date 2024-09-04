// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CoffeeFund {
    // database stores
    mapping(address => uint256) public coffeeFunds;
    mapping(address => string) public userNames;

    // deposit money from one user's wallet to a user's coffee fund
    event Deposit(address indexed user, uint256 amount);
    // withdraw money from user's coffe fund
    event Withdrawal(address indexed user, uint256 amount);

    function registerUser(string memory _name) public {
        userNames[msg.sender] = _name;
    }

    modifier isUserRegistered(address _user) {
        require(bytes(userNames[_user]).length > 0, "User not registered");
        _;
    }

    modifier hasSufficientBalance(uint256 amount) {
        require(address(this).balance >= amount, "Contract ETH balance is insufficient");
        _;
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getUserNames(address _user) public view returns (string memory) {
        return userNames[_user];
    }

    function getCoffeeFunds(address _user) public view returns (uint256) {
        return coffeeFunds[_user];
    }

    function deposit(address _user) public payable isUserRegistered(_user) {
        require(msg.value > 0, "Can't buy a coffe with that!");
        coffeeFunds[_user] += msg.value;
        emit Deposit(_user, msg.value);
    }

    function withdraw(uint256 amount) public isUserRegistered(msg.sender) hasSufficientBalance(amount) {
        address user = msg.sender;

        // withdraw user funds
        require(amount > 0, "Cannot withdraw 0");
        uint256 funds = coffeeFunds[user];
        require(funds >= amount, "Insufficient funds");
        coffeeFunds[user] -= amount;

        // pay user
        payable(user).transfer(amount);
        emit Withdrawal(user, amount);
    }
}
