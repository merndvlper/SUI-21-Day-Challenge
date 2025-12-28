/// DAY 12: Option for Task Lookup
/// 
/// Today you will:
/// 1. Learn about Option<T> type
/// 2. Write a function to find tasks by title
/// 3. Handle the case when task is not found
///
/// Note: You can copy code from day_11/sources/solution.move if needed

module challenge::day_12;

use std::string::String;
use std::vector;

const NOT_VALID_VALUE:u64 = 1;
// Copy from day_11: TaskStatus, Task, and TaskBoard
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

// TODO: Write a function 'find_task_by_title' that:
public fun find_task_by_title(board: &TaskBoard, title: &String ):Option<u64>{

    let length = vector::length(&board.tasks); 
    let mut index = 0;

    while(index < length){ // Etkinliğe gidilecek [9]
        let task = vector::borrow(&board.tasks, index);
        if(*&task.title == *title){
            return option::some(index)
        };
        index = index + 1;
    };

    option::none()
}

#[test_only]
use std::option::is_some;

#[test_only]
use std::debug::print;

#[test]
fun test_find_task_by_title(){
    let mut board = new_board(@0x00123);

    let new_task= new_task(b"Challenge 12".to_string(), 100);
    let new_task_2= new_task(b"Corba".to_string(), 120);

    add_task(&mut board , new_task);
    add_task(&mut board , new_task_2);

    let result = find_task_by_title(&board, &(b"Corba".to_string()));

    let booll = is_some(&result);

    assert!(booll == true, NOT_VALID_VALUE);

    print(&result);
}


