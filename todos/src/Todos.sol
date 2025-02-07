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

    mapping(uint256 => TodoItem) public todos;

    constructor() {
        todos[0] = EMPTY_TODO;
    }

    mapping(address => TodoItem[]) public ownerToTodos;
}