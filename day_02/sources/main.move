/// DAY 2: Primitive Types & Simple Functions
/// 
/// Today you will:
/// 1. Practice with primitive types (u64, bool)
/// 2. Write your first function
/// 3. Write your first test

module challenge::day_02;

// TODO: Write a function called 'sum' that takes two u64 numbers
public fun sum(number_1:u64, number_2:u64): u64{
    number_1 + number_2
}

#[test_only]
use std::unit_test::assert_eq;

// TODO: Write a test function that checks sum(1, 2) == 3
#[test]
fun sum_test(){
    let sum= sum(1,2);
    assert_eq!(sum,3);
}



