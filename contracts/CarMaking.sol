//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CarMaking {

struct Car {

    uint carID; 
    string model; 
    address customer; 
    address owner; 
    uint year;  
    string carLicense; 
    bool isAvailable;
    uint price;
}

}