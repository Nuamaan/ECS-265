// pragma solidity ^0.5.1;
pragma solidity >=0.4.22 <0.8.0;

contract Promise {
    uint256 public totPromise;              // To index the promises
    address payable manager;
    mapping(uint256=>Prom) unConfirmedProm; // Holds unconfirmed promises initially before they are signed by the participating parties.
    mapping(uint256=>Prom) ConfirmedProm;   // Holds confirmed promises.
    mapping(uint256=>Prom) rejectedProm;    // Holds rejected promises i.e promises rejected by any one party.
    
    
    constructor() public {
        manager=msg.sender;
    }
    
    modifier isManager() {
        require(msg.sender==manager);
        _;
    }
    
    /* 
        This event is to notify the other participating party of the promise being created
    */
    event notify (
        address P2,
        uint256 ind,
        string oath
    );
    
    /* 
        A struct that holds the address and the boolean variable annotating that parties commitment status
    */
    struct partyStatus {  
        address P;
        bool commitment;
    }
    
    /* 
        A structure holding our promise and the parties involved and their commitment towards the promise
    */
    struct Prom {
        uint256 promIndex;
        partyStatus P1;
        partyStatus P2;
        string oath;
        bool status;   
    }

    /*
        This function is used by one of the parties called a builder to create the unConfirmedPrompromise,
        the address of the second party and the oath are also passed as parameters.
        No malicious builder would want to call this function because this function takes in ehters and passes them to the manager.
    */ 
    function addPromise(address builder,address P2,string memory _oath) public payable {
        require(msg.sender==builder);
        totPromise++;

        unConfirmedProm[totPromise]=Prom(totPromise,partyStatus(builder,true),partyStatus(P2,false), _oath,false);
        
        manager.transfer(msg.value);    /* Ethers are passed to the manager, calling addPromise function would cost the builder */
        
        /* 
            The event is emitted, the other part gets to know about the promoise being created 
            by its name as one of the involved parties
        */
        emit notify(P2,totPromise,_oath);   
 
    }

    /*
        This function is used by the involved parties to view the promise 
    */
    function viewPromise(uint256 ind) public view returns(string memory) {
        require(msg.sender==unConfirmedProm[ind].P2.P || msg.sender==unConfirmedProm[ind].P1.P || msg.sender==manager||msg.sender==ConfirmedProm[ind].P2.P || msg.sender==ConfirmedProm[ind].P1.P);
        return unConfirmedProm[ind].oath;
        
    }
    
    /* 
        This function is used by the other party to sign the promise and hence 
        confirms the promise
    */
    function signPromise(uint256 ind) public payable {
        require(unConfirmedProm[ind].P2.P==msg.sender);
        unConfirmedProm[ind].P2.commitment=true;
        unConfirmedProm[ind].status=true;
        confirmpromise(ind);
        manager.transfer(msg.value);
    }
    
    /*
        This function is used by the non-builder party to reject the promise. 
        The promise after being rejected is added to the rejectPromise mapping 
    */
    function rejectPromise(uint256 ind) public payable {
        require(unConfirmedProm[ind].P2.P==msg.sender);
        unConfirmedProm[ind].status=false;
        rejectedProm[ind]=unConfirmedProm[ind];
        
    }
    
    /* 
        This function is used to confirm promises and transfer them from
        unConfirmedProm to ConfirmedProm mapping
    */
    function confirmpromise(uint256 ind) internal {
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        require(unConfirmedProm[ind].status==true);
        ConfirmedProm[ind]=unConfirmedProm[ind];
    }
}
