/// DAY 10: Visibility Modifiers (Public vs Private Functions)
/// 
/// Today you will:
/// 1. Learn about visibility modifiers (public vs private)
/// 2. Design a public API
/// 3. Write a function to complete tasks
///
/// Note: You can copy code from day_09/sources/solution.move if needed

module challenge::day_10;

use std::string::String;

const STATUS_ERROR: u64= 1;
// Copy from day_09: TaskStatus enum and Task struct
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

public fun is_open(task: &Task): bool {
    task.status == TaskStatus::Open
}

// TODO: Write a public function 'complete_task' that:
public fun complete_task(task: &mut Task){
    task.status = TaskStatus::Completed;
}
  

// TODO: (Optional) Write a private helper function
fun helper(task: &Task):bool{
    task.reward > 0
}

public fun has_reward(task:&Task):bool{
    helper(task)
}

#[test]
fun test_complete_task(){
    let mut task = new_task(b"Sui Challenge Day 10".to_string(),10);

    complete_task(&mut task);

    assert!(task.status == TaskStatus::Completed, STATUS_ERROR);
}

#[test_only]
use std::debug::print;

#[test]
fun test_has_reward(){
    let mut new_task = new_task(b"Finish Test".to_string(),150);
    
    is_open(&new_task);
    
    complete_task(&mut new_task);
    
    assert!(has_reward(&new_task) == true, 0);

    print(&new_task);
}
    