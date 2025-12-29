/// DAY 13: Simple Aggregations (Total Reward, Completed Count)
/// 
/// Today you will:
/// 1. Write functions that iterate over vectors
/// 2. Calculate totals and counts
/// 3. Practice with control flow
///
/// Note: You can copy code from day_12/sources/solution.move if needed

module challenge::day_13;

use std::string::String;

// Copy from day_12: All structs and functions
public enum TaskStatus has copy, drop {
    Open,
    Completed,
}

public struct Task has copy, drop {
    title: String,
    reward: u64,
    status: TaskStatus,
}

public struct TaskBoard has drop {
    owner: address,
    tasks: vector<Task>,
}

public fun complete_task(task: &mut Task){
    task.status = TaskStatus::Completed;
}

public fun new_task(title: String, reward: u64): Task {
    Task {
        title,
        reward,
        status: TaskStatus::Open,
    }
}

public fun new_board(owner: address): TaskBoard {
    TaskBoard {
        owner,
        tasks: vector::empty(),
    }
}

public fun add_task(board: &mut TaskBoard, task: Task) {
    vector::push_back(&mut board.tasks, task);
}

public fun find_task_by_title(board: &TaskBoard, title: &String): Option<u64> {
    let len = vector::length(&board.tasks);
    let mut i = 0;
    while (i < len) {
        let task = vector::borrow(&board.tasks, i);
        if (*&task.title == *title) {
            return option::some(i)
        };
        i = i + 1;
    };
    option::none()
}

// TODO: Write a function 'total_reward' that:
public fun total_reward(board: &TaskBoard): u64{
    let len = vector::length(&board.tasks);
    let mut total_reward = 0;
    let mut index = 0;

    while(index < len){
        let task = vector::borrow(&board.tasks, index);
        total_reward= total_reward + task.reward;
        index = index + 1;
    };

    total_reward
}
    
  

// TODO: Write a function 'completed_count' that:
public fun completed_count(board: &TaskBoard): u64{
    let len = vector::length(&board.tasks);
    let mut count = 0;
    let mut index = 0;

    while(index < len){
        let task = vector::borrow(&board.tasks, index);
        if(task.status == TaskStatus::Completed){
            count = count + 1;
        };
        index = index + 1;
    };

    count
}
   
#[test]
fun test_total_reward(){
    let mut new_board = new_board(@0xBEE);
    let mut homework_task = new_task(b"Do Homework".to_string(), 43);
    let challenge_task = new_task(b"SUI 21 Day Challenge, Day 13".to_string(), 46);

    complete_task(&mut homework_task);

    add_task(&mut new_board, homework_task);
    add_task(&mut new_board, challenge_task);

    let total = total_reward(&new_board);
    assert!(total == 89, 2);

    let count = completed_count(&new_board);
    assert!(count == 1 , 2);
}

