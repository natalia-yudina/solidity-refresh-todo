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

	function createTodo(string memory _todoTitle, string memory _todoDescription) public {
    	uint256 todoId = todoIncrement++;
    	TodoItem memory todoItem = TodoItem(todoId, _todoTitle, _todoDescription, false, msg.sender);
    	todos[todoId] = todoItem;
    	ownerToTodos[msg.sender].push(todos[todoId]);
    	emit TodoCreated(todoId);
	}

	function updateTodo(uint256 _todoId, string memory _todoTitle, string memory _todoDescription) public {
    	require(_todoId <= todoIncrement, "Todo item does not exist!");
    	TodoItem memory todoItem = todos[_todoId];
    	todoItem.todoTitle = _todoTitle;
    	todoItem.todoDescription = _todoDescription;
    	todos[_todoId] = todoItem;
    	emit TodoUpdated(_todoId);
	}
    mapping(address => TodoItem[]) public ownerToTodos;
}