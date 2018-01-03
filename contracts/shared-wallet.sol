pragma solidity ^0.4.0;
contract sharedwallet {
	uint amount;
	address owner;

	event Deposit(address _sender, uint amountSent);
	event Withdrawal(address _withdrawer, address _recipient, uint amountWithdrew);
	
	struct UserPermission {
	    bool exists;
		bool canSend; //can send money TO the wallet
		bool canWithdraw; // can withdraw money from the wallet
	}

	mapping (address => UserPermission) users;


	function sharedwallet() public payable {

		owner = msg.sender;
		addUser(owner, true, true);	
		Deposit(msg.sender, msg.value);

	}


	function addUser(address add, bool canSend, bool canWithdraw) public {
		// only the owner can add users
		if (msg.sender == owner) {
			UserPermission newUserPermission;
			newUserPermission.exists = true;
			newUserPermission.canSend = canSend;
			newUserPermission.canWithdraw = canWithdraw;
			if (users[add].exists == true) {
			    revert();
			}
			else {
		        users[add] = newUserPermission;    
			}
				
		}
		else {
			revert();
		}
		
	}



	function() payable {
        UserPermission permissions = users[msg.sender];
		if (permissions.canSend == true ) {
			Deposit(msg.sender, msg.value);
		}
		else {
			revert();
		}
	}


	function WithdrawFunds(uint amountToWithdraw, address recipient) returns (uint) {

		if (users[msg.sender].canWithdraw == true) {
			if (this.balance >= amountToWithdraw) {
				recipient.transfer(amountToWithdraw);
				Withdrawal(msg.sender, recipient, amountToWithdraw);
				
			}
			
		}
		return this.balance;

	}

	function setUserPermissions(address add, bool canSend, bool canWithdraw) {
		// Only the owner can change the permissions
		if (msg.sender == owner) {
			if (users[add].exists == true) {
				users[add].canSend = canSend;
				users[add].canWithdraw = canWithdraw;
			}
			else {
				revert();
			}
		}
	}

	function getUserPermissions(address add) constant returns (bool, bool) {
		return (users[add].canSend, users[add].canWithdraw);
	}
	
	function getAmount() constant returns (uint) {
	    return this.balance;
	}

	function killWallet() {
		if (msg.sender == owner) {
			suicide(owner);
		}
	}





}