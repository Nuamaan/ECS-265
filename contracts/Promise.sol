// pragma solidity ^0.5.1;
pragma solidity >=0.4.22 <0.8.0;
// pragma experimental ABIEncoderV2;

contract Promise {
    uint256 public totPromise;              // To index the promises
    address payable manager;
<<<<<<< Updated upstream
    mapping(uint256=>Prom) unConfirmedProm; // Holds unconfirmed promises initially before they are signed by the participating parties.
    mapping(uint256=>Prom) ConfirmedProm;   // Holds confirmed promises.
    mapping(uint256=>Prom) rejectedProm;    // Holds rejected promises i.e promises rejected by any one party.
    
    
=======
    mapping(uint256=>Prom) unConfirmedProm;         // to hold unconfirmed promises initially before they are signed by the participating parties.
    mapping(uint256=>Prom) ConfirmedProm;           // to hold confirmed promises.
    mapping(uint256=>Prom) rejectedProm;     // to hold rejected promises i.e promises rejected by any one party.
    mapping(address=>uint256[]) Confirmed;   //Confirmed promises per user address
    mapping(address=>uint256[]) Rejected;    //rejected promises per user address
    mapping(address=>uint256[]) unConfirmed; //unConfirmed promises per user

    bytes32[] public pendingProm; // TEMPORARY
      
>>>>>>> Stashed changes
    constructor() public {
        manager=msg.sender;
    }
    
<<<<<<< Updated upstream
    modifier isManager() {
=======
    modifier isManager(){
>>>>>>> Stashed changes
        require(msg.sender==manager);
        _;
    }
    
<<<<<<< Updated upstream
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
=======
    /* this event is to notify the other participating party of the promise being created*/
    event notify(
        address P2,
        uint256 ind,
        // string oath
        bytes32 oath
    );
    
    /* a struct that holds the address and the boolean variable annotating that parties commitment status*/
    struct partyStatus{  
>>>>>>> Stashed changes
        address P;
        bool commitment;
    }
    
<<<<<<< Updated upstream
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
=======
    /*a structure holding our promise and the parties involved and their commitment towards the promise*/
    struct Prom{
        uint256 promIndex;
        partyStatus P1;
        partyStatus P2;
        // string oath;
        bytes32 oath;
        bool status;
        
    }
   
    /*this function is used by one of the parties called a builder to create the unConfirmedPrompromise,
    the address of the second party and the oath are also passed as parameters.*/
    /* no malicious builder would want to call this function because this function takes in ehters and passes them to the manager.*/
    function addPromise(address builder,address P2,bytes32 _oath) public payable returns(uint256){ 
    // function addPromise(address builder,address P2,string memory _oath) public payable returns(uint256){ 
>>>>>>> Stashed changes
        require(msg.sender==builder);
        //require(msg.value==2 e);
        manager.transfer(msg.value);        /*ethers are passed to the manager,,,calling addPromise function would cost the builder*/
        
        totPromise++;

        pendingProm.push(_oath);

        unConfirmedProm[totPromise]=Prom(totPromise,partyStatus(builder,true),partyStatus(P2,false), _oath,false);
        
<<<<<<< Updated upstream
        manager.transfer(msg.value);    /* Ethers are passed to the manager, calling addPromise function would cost the builder */
=======
        unConfirmed[builder].push(totPromise); // pushing the promise index into the unconfirmed  mapping keyed by the address.
        unConfirmed[P2].push(totPromise);
        
        
        emit notify(P2,totPromise,_oath);   /* the event is emitted,,,, the other part gets to know about the promoise being created 
                                               // by its name as one of the involved parties*/
        return totPromise;
>>>>>>> Stashed changes
        
        /* 
            The event is emitted, the other part gets to know about the promoise being created 
            by its name as one of the involved parties
        */
        emit notify(P2,totPromise,_oath);   
 
    }

<<<<<<< Updated upstream
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
=======
    /*this function is used by the involved parties to view the promise */
    function viewPromise(uint256 ind) public view returns(bytes32[] memory){ 
    // function viewPromise(uint256 ind) public view returns(string memory){ 
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        // return unConfirmedProm[ind].oath;
        return pendingProm;
        
    }
    
    /* this function is used by the other party to sign the promise and hence 
    confirms the promise*/
>>>>>>> Stashed changes
    function signPromise(uint256 ind) public payable {
        require(msg.sender==unConfirmedProm[ind].P2.P);
        //require(msg.value==2 ethers);
        unConfirmedProm[ind].P2.commitment=true;
        unConfirmedProm[ind].status=true;
        confirmpromise(ind);
        manager.transfer(msg.value);
        
        Confirmed[msg.sender].push(ind);                //adding the promise to the Confirmed list of promises
        Confirmed[unConfirmedProm[ind].P1.P].push(ind); //adding the promise to the Confirmed list of promises
        
        
        // deleting the entries from the unConfirmed mapping once the promise gets signed.
        uint256[] memory l;
        l=unConfirmed[msg.sender];
        for(uint i;i<l.length;i++){
            if (l[i]==ind){
                delete unConfirmed[msg.sender][i];
            }
        }
        
        uint256[] memory l1;
        l1=unConfirmed[unConfirmedProm[ind].P1.P];
        for(uint i;i<l1.length;i++){
            if (l1[i]==ind){
                delete unConfirmed[unConfirmedProm[ind].P1.P][i];
            }
        }
    }
    
<<<<<<< Updated upstream
    /*
        This function is used by the non-builder party to reject the promise. 
        The promise after being rejected is added to the rejectPromise mapping 
    */
    function rejectPromise(uint256 ind) public payable {
        require(unConfirmedProm[ind].P2.P==msg.sender);
=======
    /*this function is used by the non-builder party to reject the promise. 
    The promise after being rejected is added to the rejectPromise mapping */
    function rejectPromise(uint256 ind) public  {
        require(msg.sender==unConfirmedProm[ind].P2.P);
>>>>>>> Stashed changes
        unConfirmedProm[ind].status=false;
        rejectedProm[ind]=unConfirmedProm[ind];
        Rejected[msg.sender].push(ind);                 // insert the rejected promise into the rejected mapping
        Rejected[unConfirmedProm[ind].P1.P].push(ind);  // insert the rejected promise into the rejected mapping
        emit notify(msg.sender,ind,unConfirmedProm[ind].oath);
        
        uint256[] memory l;                    // deleting the promise from unConfirmed mapping.
        l=unConfirmed[msg.sender];
        for(uint i;i<l.length;i++){
            if (l[i]==ind){
                delete unConfirmed[msg.sender][i];
            }
        }
        
        uint256[] memory l1;
        l1=unConfirmed[unConfirmedProm[ind].P1.P];
        for(uint i;i<l1.length;i++){
            if (l1[i]==ind){
                delete unConfirmed[unConfirmedProm[ind].P1.P][i];
            }
        }
    }
    
<<<<<<< Updated upstream
    /* 
        This function is used to confirm promises and transfer them from
        unConfirmedProm to ConfirmedProm mapping
    */
=======
    /* this function is used to confirm promises and transfer them from
   unConfirmedProm to ConfirmedProm mapping*/
>>>>>>> Stashed changes
    function confirmpromise(uint256 ind) internal {
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        require(unConfirmedProm[ind].status==true);
        ConfirmedProm[ind]=unConfirmedProm[ind];
        
    }

    /* this function would be used to view the Confirmed Promises by their owner. */ 
    function viewConfirmed() public view returns(uint256[] memory){
       
       return Confirmed[msg.sender];
        
    }

    /* this function would be used to view the Confirmed Promises by their owner. */ 
    function viewRejected() public view returns(uint256[] memory){
       
        return Rejected[msg.sender];
        
    }
<<<<<<< Updated upstream
=======
    
    function viewUnConfirmed() public view returns(uint256[] memory){
       
        return unConfirmed[msg.sender];
        
    }
    
>>>>>>> Stashed changes
}
