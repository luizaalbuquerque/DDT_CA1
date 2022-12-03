//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import {CarMaking} from "./CarMaking.sol";

/*
Gabriel Antoniolli 20202352
Luiza Cavalcanti de Albuquerque Brayner 2020309
Wallace Esteves 2020326
Caio Machado 2020351

*/

contract CarRental {

    // Gabriel
    uint balanceReceived;
    
    // total number of cars available - Gabriel
    CarMaking.Car[] cars;

    //cars array length getter - Gabriel
    function getNumberOfCars() public view returns(uint) {
        return cars.length;
    }

    // show the amount received by the contract - Gabriel
    function getBalanceReceived() public view returns(uint){

        return address(this).balance;
    }

    // Function where users car add cars for renting in the rental app. - Luiza
    function addCarForRenting(string memory model, address owner, uint year, string memory carLicense, uint price) public returns(uint) {

        //assining a variable count to hold the ID that is going to be given to the car.
        uint count =  getNumberOfCars();

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
    // Caio / Gabriel
    function rentingACar(uint carID) public payable returns (bool){

        //Making sure the customer inserts a valid ID for this to work
        require(carID >= 0 && carID <= getNumberOfCars());

        // also checking if the user is paying the right amount.
        if(msg.value != cars[carID].price){
            revert InvalidPrice(cars[carID].price);
        }
        // with this line, we ensure that the chosen car can only be rented if available.
        require(cars[carID].isAvailable == true);

        //updating chosen car properties
        cars[carID].customer = msg.sender;
        cars[carID].isAvailable = false;

        balanceReceived = msg.value;

        return true;
    }
     // Wallace / Gabriel
     function withdrawMoney(uint carID) public {
         require(cars[carID].owner == msg.sender);
        address payable to = payable(msg.sender);
        to.transfer(getBalanceReceived());
    }

    // with this function the customer can see more details about the car that he/she inserted the id.
    // Caio
    function getCarInfo(uint carID) public view returns (uint, string memory, address, address, uint, string memory, bool, uint){

        // again making sure the user inserts a valid carID.
        require(carID >= 0 && carID < getNumberOfCars());

        //find and assing car 
        CarMaking.Car memory chosenCar = cars[carID];
        return (chosenCar.carID, chosenCar.model, chosenCar.owner, chosenCar.customer, chosenCar.year, chosenCar.carLicense, chosenCar.isAvailable, chosenCar.price);
    } 

    //this function lets the car owner sets his car as returned.
    // Wallace
    function carReturned(uint carID) public returns (bool){

        CarMaking.Car storage rentedCar = cars[carID];

        // makes it only accept this function to be called by the car's owner.
        require(rentedCar.owner == msg.sender);

        //seting availability back to true and the customer's address back to the default one.
        rentedCar.isAvailable = true;
        rentedCar.customer = address(0);
        
        return true;
    }
}