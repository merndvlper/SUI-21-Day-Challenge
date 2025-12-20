/// DAY 4: Vector + Ownership Basics
/// 
/// Today you will:
/// 1. Learn about vectors
/// 2. Create a list of habits
/// 3. Understand basic ownership concepts

module challenge::day_04;

// Copy the Habit struct from day_03
public struct Habit has copy, drop {
    name: vector<u8>,
    completed: bool,
}

public fun new_habit(name: vector<u8>): Habit {
    Habit {
        name,
        completed: false,
    }
}

// TODO: Create a struct called 'HabitList' with:
public struct HabitList has drop{
    habits: vector<Habit>
}

// TODO: Write a function 'empty_list' that returns an empty HabitList
public fun empty_list(): HabitList{
    HabitList{
        habits: vector::empty()
    }
}

// TODO: Write a function 'add_habit' that takes:
public fun add_habit(list: &mut HabitList, habit: Habit){
    vector::push_back(&mut list.habits, habit);
}



#[test_only]
use std::unit_test::assert_eq;
#[test_only]
use std::debug::print;

#[test]
fun add_habit_test(){
    let mut empty_habit_list = empty_list();
    assert_eq!(empty_habit_list.habits , vector[]);

    let new_habit= new_habit(vector[2]);
    print(&new_habit);

    add_habit(&mut empty_habit_list, new_habit);
    print(&empty_habit_list);
    assert_eq!(empty_habit_list.habits, vector[new_habit]);
}
