/// DAY 3: Structs (Habit Model Skeleton)
/// 
/// Today you will:
/// 1. Learn about structs
/// 2. Create a Habit struct
/// 3. Write a constructor function

module challenge::day_03;

// TODO: Define a struct called 'Habit' with:
public struct Habbit has copy, drop{
    name: vector<u8>,
    completed: bool
}

// TODO: Write a constructor function 'new_habit'
public fun new_habbit(name: vector<u8>): Habbit{
    Habbit{
        name,
        completed:false
    }
}

#[test_only]
use std::unit_test::assert_eq;
#[test_only]
use std::debug::print;

#[test]
fun test_new_habbit(){
    let mut vector_name = vector::empty<u8>(); 
    vector::push_back(&mut vector_name, 5);
    
    print(&vector_name);
    assert!(vector::borrow(&vector_name, 0) == 5, 42);

    let new_habbit = new_habbit(vector_name);

    assert_eq!(new_habbit.name, vector[5]);
    print(&new_habbit);
}




