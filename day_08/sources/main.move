/// DAY 8: New Module & Simple Task Struct
/// 
/// Today you will:
/// 1. Start a new project: Task Bounty Board
/// 2. Create a Task struct
/// 3. Write a constructor function

module challenge::day_08;

use std::string::String;

// TODO: Define a struct called 'Task' with:
public struct Task has copy, drop{
    title: String,
    reward: u64,
    done: bool
}

 // TODO: Write a constructor function 'new_task'
public fun new_task(title:String, reward: u64):Task{
    Task{
        title,
        reward,
        done: false
    }
}

#[test_only]
use std::unit_test::assert_eq;

#[test]
fun test_new_task(){
    let new_task = new_task(b"Sui Challenge Day 07".to_string(), 100);
    assert_eq!(new_task.reward, 100);
}
   


