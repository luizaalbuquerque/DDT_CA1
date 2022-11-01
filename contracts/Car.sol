pragma solidity >=0.7.0 <0.9.0;

contract Car {

    uint public carID;
    string public carName;
    bool public availability;
    
    constructor(uint id, string memory name, bool status) public {

        carID = id;
        carName = name;
        availability = status;
    }

    function getID() public  returns(uint) {
        return carID;
    }
    
    function setAvailability(bool newStatus) public {
        availability = newStatus;
    }


}