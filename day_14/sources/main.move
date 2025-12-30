/// DAY 14: Tests for Bounty Board
/// 
/// Today you will:
/// 1. Write comprehensive tests
/// 2. Test all the functions you've created
/// 3. Practice test organization
///
/// Note: You can copy code from day_13/sources/solution.move if needed

module challenge::day_14;

use std::string::String;

const ADD_TASK_ERROR: u64 = 1;
const TOTAL_REWARD_ERROR: u64 = 2;

#[test_only]
use std::unit_test::assert_eq;

// Copy from day_13: All structs and functions
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

public fun complete_task(task: &mut Task) {
    task.status = TaskStatus::Completed;
}

public fun total_reward(board: &TaskBoard): u64 {
    let len = vector::length(&board.tasks);
    let mut total = 0;
    let mut i = 0;
    while (i < len) {
        let task = vector::borrow(&board.tasks, i);
        total = total + task.reward;
        i = i + 1;
    };
    total
}

public fun completed_count(board: &TaskBoard): u64 {
    let len = vector::length(&board.tasks);
    let mut count = 0;
    let mut i = 0;
    while (i < len) {
        let task = vector::borrow(&board.tasks, i);
        if (task.status == TaskStatus::Completed) {
            count = count + 1;
        };
        i = i + 1;
    };
    count
}

#[test_only]
const MUSA: address = @0x134;

// TODO: Write at least 3 tests:

// Test 1: test_create_board_and_add_task
#[test]
fun test_create_board_and_add_task(){
    let mut board= new_board(MUSA);
    let task = new_task(b"SUI 21 Day Challenge Day 14".to_string(),10);

    add_task(&mut board, task);

    let length = vector::length(&board.tasks);

    assert!(length == 1, ADD_TASK_ERROR);
}

// Test 2: test_complete_task
#[test]
fun test_complete_task(){
    let mut board = new_board(MUSA);
    let task_1 = new_task(b"Learn SUI Ecosystem".to_string(), 30); 
    
    add_task(&mut board, task_1);
    

    let task = vector::borrow_mut(&mut board.tasks, 0);
    complete_task(task);

    assert_eq!(completed_count(&board) , 1);
}
   
// Test 3: test_total_reward
#[test]
fun test_total_reward(){
    let mut board = new_board(MUSA);

    let task_1 = new_task(b"Work A".to_string(), 15);
    let task_2 = new_task(b"Work B".to_string(), 30);
    let task_3 = new_task(b"Work C".to_string(), 45);

    add_task(&mut board, task_1);
    add_task(&mut board, task_2);
    add_task(&mut board, task_3);

    assert!(total_reward(&board) == 90, TOTAL_REWARD_ERROR );
}


