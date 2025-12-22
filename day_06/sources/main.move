/// DAY 6: String Type for Habit Names
/// 
/// Today you will:
/// 1. Learn about the String type
/// 2. Convert vector<u8> to String
/// 3. Update Habit to use String instead of vector<u8>
///
/// Note: You can copy code from day_05/sources/solution.move if needed

module challenge::day_06;
use std::string::{Self, String};

// Copy from day_05: Habit struct (will be updated to use String)
public struct Habit has copy, drop {
    name: String,  // TODO: Change this to String
    completed: bool,
}

// Copy from day_05: HabitList struct
public struct HabitList has drop {
    habits: vector<Habit>,
}

public fun empty_list(): HabitList {
    HabitList {
        habits: vector::empty(),
    }
}

public fun add_habit(list: &mut HabitList, habit: Habit) {
    vector::push_back(&mut list.habits, habit);
}

public fun complete_habit(list: &mut HabitList, index: u64) {
    let len = vector::length(&list.habits);
    if (index <= len) {
        let habit = vector::borrow_mut(&mut list.habits, index);
        habit.completed = true;
    }
}

// TODO: Update new_habit to accept String
public fun new_habit(name:String): Habit{
    Habit{
        name,
        completed: false
}
}

    // TODO: Write a helper function 'make_habit' that:
public fun make_habit(name_bytes: vector<u8>): Habit{
    let name= string::utf8(name_bytes);
    new_habit(name)
}

#[test_only]
use std::debug::print;

#[test]
fun test_make_habit(){
    let mut new_list = empty_list();
    
    let make_habit= make_habit(vector[65]);
    let new_habit = new_habit(make_habit.name);

    add_habit(&mut new_list, new_habit);

    complete_habit(&mut new_list , 0);
    
    print(&new_list.habits[0]);
}
