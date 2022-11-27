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
    //error to be called by next function
    error InvalidPrice(uint correctPrice);

    // function that customer calls to rent a car, the user only needs to insert the id of the car he is interested. and pay the value
    // if the value is different from the car's price, this logic was taken from this link here:
    // https://ethereum.stackexchange.com/questions/125092/payments-pre-set-value-in-solidity
    function rentingACar(uint carID) public payable returns (bool){

        //Making sure the customer inserts a valid ID for this to work
        require(carID >= 0 && carID < getNumberOfCars());

        // also checking if the user is paying the right amount.
        if(msg.value != cars[carID].price)
            revert InvalidPrice(cars[carID].price);

        // with this line, we ensure that the chosen car can only be rented if available.
        require(cars[carID].isAvailable == true);

        //updating chosen car properties
        cars[carID].customer = msg.sender;
        cars[carID].isAvailable = false;

        return true;
    }
}