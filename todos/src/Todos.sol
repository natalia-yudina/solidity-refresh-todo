// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;

contract Todos {
	struct TodoItem {
    	uint256 todoID;
    	string todoTitle;
    	string todoDescription;
    	bool completed;
    	address todoOwner;
	}
	
	// Use this as a reference when referring to an empty TODO
	TodoItem public EMPTY_TODO = TodoItem(0, "", "", false, 0x0000000000000000000000000000000000000000);

    mapping(uint256 => TodoItem) public todos;

    constructor() {
        todos[0] = EMPTY_TODO;
    }
	uint256 public todoIncrement = 1;

	event TodoCreated(uint256 indexed todoId);
	event TodoUpdated(uint256 indexed todoId);
	event TodoDeleted(uint256 indexed todoId);
	
    mapping(address => TodoItem[]) public ownerToTodos;
}