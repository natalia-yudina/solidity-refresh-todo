import { useAccount, useConnect, useDisconnect } from 'wagmi';
import { useWatchTodosTodoCreated, useWatchTodosTodoDeleted, useWatchTodosTodoUpdated, useWriteTodosCreateTodo, useWriteTodosDeleteTodo, useWriteTodosUpdateTodo } from './generated.ts'
import { type FormEvent, useState } from 'react';
import { config } from './wagmi.ts';
import type { Address } from 'viem';

const contractAddress: Address = "0x5a13b12ddd9c1133312bd78587d1d0c021e96b98";

function CreateTodoForm() {
	useWatchTodosTodoCreated({
    	config: config,
    	address: contractAddress,
    	onLogs(logs) {
        	console.log('Event says "created a todo"', logs)
    	},
	});
	const [todoTitle, setTodoTitle] = useState<string>("");
	const [todoDescription, setTodoDescription] = useState<string>("");
	const { writeContractAsync } = useWriteTodosCreateTodo(
    	{
        	config: config
    	}
	);

	const submitCreateTodo = async (e: FormEvent
	) => {
    	e.preventDefault();

    	await writeContractAsync({
        	address: contractAddress,
        	args: [todoTitle, todoDescription]
    	});
    	setTodoTitle("");
    	setTodoDescription("");
	}

	return (<>
    	<form onSubmit={(e) => submitCreateTodo(e)}>
        	<input type="text" name="todo-title" value={todoTitle} placeholder='Todo Title' onChange={(e) => setTodoTitle(e.target.value)} />
        	<textarea
            	rows={5}
            	name="todo-description"
            	placeholder="What's on your mind?"
            	value={todoDescription}
            	onChange={(e) =>
                	setTodoDescription(e.target.value)
            	}
        	/>
        	<button type="submit">Submit New Todo</button>
    	</form>
	</>)
}