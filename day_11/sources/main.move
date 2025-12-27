/// DAY 11: TaskBoard & Address Type
/// 
/// Today you will:
/// 1. Learn about the address type
/// 2. Create a TaskBoard that tracks ownership
/// 3. Understand ownership in practice
///
/// Note: You can copy code from day_10/sources/solution.move if needed
/// 
/// Related: Day 10 (Visibility), Day 12 (Building on TaskBoard)

module challenge::day_11;
use std::string::String;

// Copy from day_10: TaskStatus enum and Task struct
public enum TaskStatus has copy, drop {
    Open,
    Completed,
}

public struct Task has copy, drop {
    title: String,
    reward: u64,
    status: TaskStatus,
}

public fun new_task(title: String, reward: u64): Task {
    Task {
        title,
        reward,
        status: TaskStatus::Open,
    }
}

public fun complete_task(task: &mut Task) {
    task.status = TaskStatus::Completed;
}

// TODO: Define a struct called 'TaskBoard' with:
public struct TaskBoard has drop{
    owner: address,
    tasks: vector<Task>
}
 

// TODO: Write a constructor 'new_board' that takes owner: address
public fun new_board(owner:address):TaskBoard{
    TaskBoard{
        owner,
        tasks: vector::empty()
    }
}
 

// TODO: Write a function 'add_task' that:
public fun add_task(board:&mut TaskBoard, task:Task){
    vector::push_back(&mut board.tasks, task);
} 

#[test_only]
use std::debug::print;

#[test]
fun test_new_board_and_add_task(){
    let new = @0x0123;
    let new_task= new_task(b"SUI 21 Day Challenge, Day 11".to_string(),200);

    let mut new_board= new_board(new);

    print(&new_board);
    
    add_task(&mut new_board, new_task);

    assert!(new_board.tasks[0].reward == 200, 2);
    
}
   
