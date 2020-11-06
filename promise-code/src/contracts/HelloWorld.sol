pragma solidity ^0.5.1;

contract Promise{
    uint256 public totPromise;//to index the promises
    address payable manager;
    mapping(uint256=>Prom) unConfirmedProm;// to hold unconfirmed promises.
    mapping(uint256=>Prom) ConfirmedProm;// to hold confirmed promises.
    
    constructor() public {
        manager=msg.sender;
    }
    
    
    modifier isManager(){
        require(msg.sender==manager);
        _;
    }
    
    /* this event is created to notify the other party of the promise created*/
    event notify(
        address P2,
        uint256 ind
        );
    
    
    struct partyStatus{  
        address P;
        bool commitment;
    }
    
    struct Prom{
        uint256 promIndex;
        partyStatus P1;
        partyStatus P2;
        string oath;
        bool status;
        
    }
    
    /*this function is used by one of the parties to create the unConfirmedPrompromise,
    the address of the second party and the oath are also passed as parameteres.*/
     
    function addPromise(address builder,address P2,string memory _oath) public payable {
        require(msg.sender==builder || msg.sender==P2);
        totPromise++;

        unConfirmedProm[totPromise]=Prom(totPromise,partyStatus(builder,true),partyStatus(P2,false), _oath,false);
        manager.transfer(msg.value);
        emit notify(P2,totPromise); 
        
        
    }
    
    /*this function is used by the other party to view the promise created by the first party*/
    
    function viewPromise(uint256 ind) public view returns(string memory){
        require(msg.sender==unConfirmedProm[ind].P2.P);
        return unConfirmedProm[ind].oath;
        
        
        
        
    }
    
    
    
    /* this function is used by the other party to sign the promise and hence 
    confirms the promise*/
    function signPromise(uint256 ind) public payable {
        require(unConfirmedProm[ind].P2.P==msg.sender);
        unConfirmedProm[ind].P2.commitment=true;
        unConfirmedProm[ind].status=true;
        confirmpromise(ind);
        manager.transfer(msg.value);
    }
    
   
   /* this function is used to confirm promises and transfer them from
   unConfirmedProm to ConfirmedProm mapping*/
   
    function confirmpromise(uint256 ind) internal {
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        require(unConfirmedProm[ind].status==true);
        ConfirmedProm[ind]=unConfirmedProm[ind];
    }
    
    
}
