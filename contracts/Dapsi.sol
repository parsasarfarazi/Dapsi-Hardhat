// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
// designed and developed by : Ali


contract Dapsi {

    event requestAccepted(address indexed client, address indexed driver, string mabda, string maghsad, uint price);
    event travelRequested(address indexed client, string mabda, string maghsad, uint price);
    //client stuff
    struct Client  {
        address clientAddress;
        string clientName;
        bool hasRequest;
    }
    Client[] public clients;
    mapping (address => uint) clientIndex;
    mapping (address => bool) isClient;
    //client stuff

    //driver Stuff
    struct Driver {
        address driverAddress;
        string driverName;
        bool inRequest;
    }
    Driver[] public drivers;
    mapping (address => uint) driverIndex;
    mapping (address => bool) isDriver;
    //driver stuff

    modifier clientModifier(bool hi) {
        if (hi) {
            require(isClient[msg.sender] == true, "not a client");
            require(clients[clientIndex[msg.sender]].hasRequest == false, "you already have a request");
            _;
        }
        else {
            require(isClient[msg.sender] == false, "you are already a client");
            require(isDriver[msg.sender] == false, "you are already a driver");
            _;
        }
    }

    modifier driverModifier(bool yo) {
       if (yo) {
            require(isDriver[msg.sender] == true, "not a driver");
            require(drivers[driverIndex[msg.sender]].inRequest == false, "you are already in request");
            _;         
       }
       else {
            require(isDriver[msg.sender] == false, "you are already a driver");
            require(isClient[msg.sender] == false, "you are already a client");
            _;
       }
    }

    // request stuff
    struct Request {
        address clientAddress;
        string mabda;
        string maghsad;
        uint256 price;
    }
    Request[] public requests;
    
    //request stuff

    function signUpClient(string memory _name) public clientModifier(false) {
        clients.push(Client(msg.sender, _name, false));
        isClient[msg.sender] = true;
        clientIndex[msg.sender] = clients.length;
    }

    function signUpDriver(string memory _name) public driverModifier(false){
        drivers.push(Driver(msg.sender, _name, false));
        isDriver[msg.sender] = true;
        driverIndex[msg.sender] = drivers.length;
    }


   function requestTravel(string memory mabda, string memory maghsad) public clientModifier(true) {

        requests.push(Request(msg.sender , mabda, maghsad, 10));
        clients[clientIndex[msg.sender]].hasRequest = true;
        emit travelRequested(msg.sender, mabda, maghsad, 10);
        
   }
   
   //function generateBid()  private   {
   //}

   function acceptRequest(uint256 _requestIndex) public driverModifier(true) {
        Request memory request = requests[_requestIndex];
        drivers[driverIndex[msg.sender]].inRequest = true;
        clients[clientIndex[request.clientAddress]].hasRequest = false;
        emit requestAccepted(request.clientAddress, msg.sender, request.mabda, request.maghsad, request.price);
        remove(_requestIndex);
   } 

    function remove(uint index) internal  {
        if (index >= requests.length) return;
        for (uint i = index; i<requests.length-1; i++){
            requests[i] = requests[i+1];
        }
            
            
    }
}