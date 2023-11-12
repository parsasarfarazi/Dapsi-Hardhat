// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Dapsi {
    mapping (address => uint) public availableRequests;

    struct Client  {
        address clientAddress;
        string clientName;
        bool hasRequest;
    }
    Client[] private clients;

    mapping (address => bool) isClient;

    struct Driver {
        address driverAddress;
        string driverName;
        bool inRequest;
    }

    Driver[] private drivers;

    mapping (address => bool) isDriver;

    modifier onlyClient() {
        require(isClient[msg.sender] == true, "not a client");
        _;
    }

    modifier onlyDriver() {
        require(isDriver[msg.sender] == true, "not a driver");
        _;
    }

    function singUp(string memory _name) public {
        clients.push(Client(msg.sender, _name, false));
        isClient[msg.sender] = true;
    }


   function requestTravel(string memory mabda, string memory maghsad) public onlyClient payable   {
        
   }
   
   function generateBid()  public  {
    
   }

   function acceptRequest(uint256 _requestId) public onlyDriver() {
    
   }
  
}