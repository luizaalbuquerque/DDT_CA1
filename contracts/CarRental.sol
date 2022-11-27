//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import {CarMaking} from "./CarMaking.sol";

contract CarRental {

    uint public balanceReceived;
    
    // total number of cars available
    CarMaking.Car[] public cars;

    //cars array length getter
    function getNumberOfCars() public view returns(uint) {
        return cars.length;
    }

    // Function where users car add cars for renting in the rental app.
    function addCarForRenting(string memory model, address owner, uint year, string memory carLicense, uint price) public returns(uint) {

        //assining a variable count to hold the ID that is going to be given to the car.
        uint count =  getNumberOfCars() + 1;

        // adding new car to the cars's array, notice that address(0) is the default address. reference below:
        //https://ethereum.stackexchange.com/questions/40559/what-are-the-initial-zero-values-for-different-data-types-in-solidity
        cars.push(CarMaking.Car(count, model, address(0) , owner, year, carLicense, true, price));

        return count;
    }
}