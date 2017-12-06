pragma solidity ^0.4.0;
contract sharedwallet {
	uint amount;
	address owner;
	
	struct User {

		address add;
		bool canSpend;
		bool canPut;
	}

	User[] users;

	function addUser(address add, bool canSpend, bool canPut) private {
		User newUser;
		newUser.add = add;
		newUser.canSpend = canSpend;
		newUser.canPut = canPut;
		users.push(newUser);
	}

	function sharedwallet(uint initial_amount) public {

		owner = msg.sender;
		addUser(owner, true, true);	
		
	}

	function sendEthToWallet(uint amount) public {

	}




}