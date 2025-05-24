// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DecentralizedTodo {
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(address => Task[]) private userTasks;
    mapping(address => uint) private taskCount;

    event TaskAdded(address indexed user, uint taskId, string content);
    event TaskToggled(address indexed user, uint taskId, bool completed);
    event TaskDeleted(address indexed user, uint taskId);

    function addTask(string memory _content) external {
        uint newTaskId = taskCount[msg.sender]++;
        userTasks[msg.sender].push(Task(newTaskId, _content, false));
        emit TaskAdded(msg.sender, newTaskId, _content);
    }

    function getTasks() external view returns (Task[] memory) {
        return userTasks[msg.sender];
    }

    function toggleTask(uint _taskId) external {
        require(_taskId < taskCount[msg.sender], "Invalid task ID");
        Task[] storage tasks = userTasks[msg.sender];
        tasks[_taskId].completed = !tasks[_taskId].completed;
        emit TaskToggled(msg.sender, _taskId, tasks[_taskId].completed);
    }

    function deleteTask(uint _taskId) external {
        require(_taskId < taskCount[msg.sender], "Invalid task ID");
        Task[] storage tasks = userTasks[msg.sender];
        delete tasks[_taskId];
        emit TaskDeleted(msg.sender, _taskId);
    }
}
