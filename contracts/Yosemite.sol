// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Yosemite {
   
   // CURRENTLY THE OWNER IS THE MSG.SENDER, BUT NEEDS TO BE MODIFIED SO WE CAN MAKE SOMEONE ELSE THE OWNER WHEN CALLING THE CONTRACT
   address public owner;

    constructor() {
        owner = msg.sender;
        contractManagers.push(owner);
        setOtherClimbersId(owner);
    }


    address[] public contractManagers;

    mapping (address => uint) public climberId;
    mapping (address => string) public climberName;
    mapping (address => bool) public isMember;
    address[] public usersArr;

//TODO => ADD MODIFIER FOR ALL MANAGERS AND REPLACE ONLY OWNER CAN CALL FUNCTIONS WITH IT

// Owner adds other managers to the contract
    function addManagers(address _newManager) public returns(address[] memory) {
        require (msg.sender == owner);
        
        contractManagers.push(_newManager);
        return contractManagers;
    }

// CREATE ACCOUNTS SECTION (2 functions)---------------
// Create Accounts function without allowing duplicates for contract caller to call (msg.sender) ✅
    function setClimberId(string memory _name) public returns(string memory){
        if(!isMember[msg.sender]) {
            climberId[msg.sender] = (usersArr.length + 1);
            usersArr.push(msg.sender);
            isMember[msg.sender] = true;
            climberName[msg.sender] = _name;
            return "Climber Succesfully Registered";
        } else {
            return "You are already registered!";
        }
    }

// Create Accounts function without allowing duplicates for someone else's address for owner to call
    function setOtherClimbersId(address _newClimber) public returns(string memory) {
        require(msg.sender == owner); //NEED TO CHANGE TO MODIFIER SO ANY MANAGER CAN DO THIS
        if(!isMember[_newClimber]) {
            climberId[_newClimber] = (usersArr.length + 1);
            usersArr.push(_newClimber);
            isMember[_newClimber] = true;
            return "Climber Succesfully Registered";
        } else {
            return "You are already registered!";
        }
    }

    function totalUsers() external view returns(uint) {
        return usersArr.length;
    }

    function allMembersAddresses() external view returns(address[] memory) {
        return usersArr;
    }
// --------------------------------------------------------END


// ROUTE STRUCT DEFINITION---------------------
    struct Route {
        uint routeId;
        string title;
        uint grade;
        // mapping(address => bool) hasClimbedIt;
        address firstAscent;
        // address[] haveBeenClimbedBy;
    }

    // CREATE ARRAY OF STRUCTS
    Route[] public routes;

    // COUNTER TO BE USED TO GENERATE IDs FOR ROUTES
    uint routesCount = routes.length;

    //FUNCTION TO CREATE A ROUTE ✅
    function createRoute(string memory _title, uint _grade) public {
        require(msg.sender == owner);
        Route memory newRoute;
        newRoute.routeId = (routesCount + 1);
        newRoute.title = _title;
        newRoute.grade = _grade;
        routes.push(newRoute);
        routesCount++;
    }
// NEW PART ADDED END---------------------

    mapping(address=> mapping(uint => bool)) climberRouteBool;

    function mappingRouteClimber(address _addr, uint _routeId) public {
        climberRouteBool[_addr][_routeId] = true;
    }

// SET FIRST ASCENT FOR ROUTE ID AND RETURN ADDRESS
    function setFirstAscent(address _climber, uint _routeId) public view returns(address) {
        for(uint i=0; i<=routesCount; i++) {
            if(routes[i].routeId == _routeId) {
                routes[i].firstAscent == _climber;
            }
        }
        return routes[_routeId].firstAscent;
    }

// RETURN FIRST ASCENT FOR ROUTE ID
    function firstAscend(uint _routeId) public view returns(address) {
        return routes[_routeId].firstAscent;
    }
}