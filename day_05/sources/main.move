/// DAY 5: Control Flow & Mark Habit as Done
/// 
/// Today you will:
/// 1. Learn if/else statements
/// 2. Learn how to access vector elements
/// 3. Write a function to mark a habit as completed

module challenge::day_05;

// Copy from day_04
public struct Habit has copy, drop {
    name: vector<u8>,
    completed: bool,
}

public struct HabitList has drop {
    habits: vector<Habit>,
}

public fun new_habit(name: vector<u8>): Habit {
    Habit {
        name,
        completed: false,
    }
}

public fun empty_list(): HabitList {
    HabitList {
        habits: vector::empty(),
    }
}

public fun add_habit(list: &mut HabitList, habit: Habit) {
    vector::push_back(&mut list.habits, habit);
}

// TODO: Write a function 'complete_habit' that:
public fun complete_habit(list: &mut HabitList, index:u64){
    let length = vector::length(&list.habits);

    if(index < length){
        let habit = vector::borrow_mut(&mut list.habits, index);
        habit.completed = true;
    }
}

#[test_only]
use std::debug::print;

#[test_only]
use std::unit_test::assert_eq;

#[test]
fun test_completed_habit(){
    let mut habit_list= empty_list();

    let new_habit= new_habit(vector[2]);
    let new_habit_2= new_habit(vector[3]);
    let new_habit_3= new_habit(vector[12]);
    
    add_habit(&mut habit_list, new_habit);
    complete_habit(&mut habit_list, 0);
    assert_eq!(habit_list.habits[0].completed , true );

    add_habit(&mut habit_list, new_habit_2);
    complete_habit(&mut habit_list, 1);
    assert_eq!(habit_list.habits[1].completed , true );

    add_habit(&mut habit_list, new_habit_3);
    complete_habit(&mut habit_list, 2);
    assert_eq!(habit_list.habits[2].completed , true );

    print(&habit_list.habits);
    
}
