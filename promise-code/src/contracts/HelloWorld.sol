pragma solidity ^0.5.1;

contract Promise{
    uint256 public totPromise;//to index the promises
    address payable manager;
    mapping(uint256=>Prom) unConfirmedProm;         // to hold unconfirmed promises initially before they are signed by the participating parties.
    mapping(uint256=>Prom) ConfirmedProm;           // to hold confirmed promises.
    mapping(uint256=>Prom) rejectedProm;     // to hold rejected promises i.e promises rejected by any one party.
    
    
    constructor() public {
        manager=msg.sender;
    }
    
    
    
    
    modifier isManager(){
        require(msg.sender==manager);
        _;
    }
    
    
    
    /* this event is to notify the other participating party of the promise being created*/
    event notify(
        address P2,
        uint256 ind,
        string oath
        );
    
    
    
    
    /* a struct that holds the address and the boolean variable annotating that parties commitment status*/
    struct partyStatus{  
        address P;
        bool commitment;
    }
    
    
    
    
    /*a structure holding our promise and the parties involved and their commitment towards the promise*/
    struct Prom{
        uint256 promIndex;
        partyStatus P1;
        partyStatus P2;
        string oath;
        bool status;
        
    }
    
   
   
   
   
    /*this function is used by one of the parties called a builder to create the unConfirmedPrompromise,
    the address of the second party and the oath are also passed as parameters.*/
    /* no malicious builder would want to call this function because this function takes in ehters and passes them to the manager.*/
     
    function addPromise(address builder,address P2,string memory _oath) public payable {
        require(msg.sender==builder);
        manager.transfer(msg.value);        /*ethers are passed to the manager,,,calling addPromise function would cost the builder*/
        
        totPromise++;

        unConfirmedProm[totPromise]=Prom(totPromise,partyStatus(builder,true),partyStatus(P2,false), _oath,false);
        
        
        
        emit notify(P2,totPromise,_oath);   /* the event is emitted,,,, the other part gets to know about the promoise being created 
                                            by its name as one of the involved parties*/
        
        
    }
    
    
    
   
   
    /*this function is used by the involved parties to view the promise */
    
    function viewPromise(uint256 ind) public view returns(string memory){
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        return unConfirmedProm[ind].oath;
        
        
        
        
    }
    
    
    
    
    
    /* this function is used by the other party to sign the promise and hence 
    confirms the promise*/
    function signPromise(uint256 ind) public payable {
        require(msg.sender==unConfirmedProm[ind].P2.P);
        unConfirmedProm[ind].P2.commitment=true;
        unConfirmedProm[ind].status=true;
        confirmpromise(ind);
        manager.transfer(msg.value);
    }
    
    
    
    
    
    
    /*this function is used by the non-builder party to reject the promise. 
    The promise after being rejected is added to the rejectPromise mapping */
    function rejectPromise(uint256 ind) public  {
        require(msg.sender==unConfirmedProm[ind].P2.P);
        unConfirmedProm[ind].status=false;
        rejectedProm[ind]=unConfirmedProm[ind];
        
    }
    
    
    
    
    
    
    
/* this function is used to confirm promises and transfer them from
   unConfirmedProm to ConfirmedProm mapping*/
   
    function confirmpromise(uint256 ind) internal {
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        require(unConfirmedProm[ind].status==true);
        ConfirmedProm[ind]=unConfirmedProm[ind];
    }
    
    
}
