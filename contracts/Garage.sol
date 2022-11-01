pragma solidity >=0.7.0 <0.9.0;

import "./Car.sol";

contract Garage {

    

     Car[] carList = new Car[](5);
    

    function addingCar(uint carID, string memory carName, bool status) public {
        carList.push(new Car(carID, carName, status));
    }

    function getCars() view public returns (Car[] memory){
        return carList;
    }

}