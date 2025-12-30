/// DAY 15: Read Object Model & Create FarmState Struct (no UID yet)
/// 
/// Today you will:
/// 1. Learn about Sui objects (conceptually)
/// 2. Create a simple struct for farm counters
/// 3. Write basic functions to increment counters
/// 
/// NOTE: Today we're NOT creating a Sui object yet, just a regular struct.
/// We'll add UID and make it an object tomorrow.

module challenge::day_15;

// TODO: Define constants for plotId validation
const MAX_PLOTS: u64 = 20;
const E_PLOT_NOT_FOUND:u64= 1;
const E_PLOT_LIMIT_EXCEEDED: u64=2;
const E_INVALID_PILOT_ID: u64 = 3;
const E_PLOT_ALREADY_EXISTS: u64 =4;

// TODO: Define a struct called 'FarmCounters' with:
public struct FarmCounters has copy, drop, store{
    planted: u64,
    harvested: u64,
    plots: vector<u8>
}

// TODO: Write a constructor 'new_counters' that returns counters with zeros
fun new_counters(): FarmCounters{
    FarmCounters{
        planted:0 ,
        harvested: 0,
        plots: vector::empty()
    }
}

// TODO: Write a function 'plant' that takes plotId: u8 and increments planted counter
fun plant(counters: &mut FarmCounters, plotId:u8) {
    assert!(plotId >= 1 && plotId <= (MAX_PLOTS as u8), E_INVALID_PILOT_ID);

    let len = vector::length(&counters.plots);
    assert!(len < MAX_PLOTS, E_PLOT_LIMIT_EXCEEDED);

    let mut index = 1;
    while(index < len){
        let existing_plot = vector::borrow(&counters.plots , index);
        assert!(*existing_plot != plotId , E_PLOT_ALREADY_EXISTS);
        index = index + 1;
    };

    counters.planted = counters.planted + 1;
    vector::push_back(&mut counters.plots, plotId);
}

// TODO: Write a function 'harvest' that takes plotId: u8 and increments harvested counter
fun harvest(counters: &mut FarmCounters, plotId:u8){
    let len = vector::length(&counters.plots);
    let mut index = 0;
    let mut found_index = len;

    while(index < len){
        let existing_plot = vector::borrow(&counters.plots, index);
        if(*existing_plot == plotId){
            found_index= index;
        };
        index = index + 1;
    };

    assert!(found_index < len , E_PLOT_NOT_FOUND);
    vector::remove(&mut counters.plots, found_index);

    counters.harvested = counters.harvested + 1;
}

#[test_only]
use std::unit_test::assert_eq;

#[test]
fun test_new_counter(){
    let mut counter = new_counters();

    plant(&mut counter, 1);
    plant(&mut counter, 2);
    plant(&mut counter, 3);

    // harvest(&mut counter, 3);

    assert_eq!(counter.plots[0] , 1);

    assert_eq!(counter.plots[2] , 3);
}