// pragma solidity ^0.5.1;
pragma solidity >=0.4.22 <0.8.0;

contract Promise{
    uint256 public totPromise;                      // To index the promises
    address payable manager;
    mapping(uint256=>Prom) unConfirmedProm;         // To hold unconfirmed promises initially before they are signed by the participating parties
    mapping(uint256=>Prom) ConfirmedProm;           // To hold confirmed promises
    mapping(uint256=>Prom) rejectedProm;            // To hold rejected promises i.e promises rejected by any one party
    mapping(address=>uint256[]) Confirmed;          // Confirmed promises per user address
    mapping(address=>uint256[]) Rejected;           // Rejected promises per user address
    mapping(address=>uint256[]) unConfirmed;        // UnConfirmed promises per user

    bytes32[] public pendingProm; // Only works for shorter promises


    constructor() public {
        manager=msg.sender;
    }
    

    modifier isManager() {
        require(msg.sender==manager);
        _;
    }
    
    /* 
        This event is to notify the other participating party of the promise being created.
    */
    event notify (
        address P2,
        uint256 ind,
        bytes32 oath
    );
    

    /* 
        A struct that holds the address and the boolean variable annotating that parties commitment status.
    */
    struct partyStatus {  
        address P;
        bool commitment;
    }
    

    /*
        A structure holding our promise and the parties involved and their commitment towards the promise.
    */
    struct Prom {
        uint256 promIndex;
        partyStatus P1;
        partyStatus P2;
        bytes32 oath;
        bool status;
        
    }
   

    /*
        This function is used by one of the parties called a builder to create the unConfirmedPrompromise,
        the address of the second party and the oath are also passed as parameters.
        No malicious builder would want to call this function because this function takes in ehters and passes them to the manager.
    */
    function addPromise(address builder,address P2,bytes32 _oath) public payable returns(uint256) { 
        require(msg.sender==builder);

        manager.transfer(msg.value);            // Ethers are passed to the manager, calling addPromise function would cost the builder
        
        totPromise++;

        pendingProm.push(_oath);

        unConfirmedProm[totPromise]=Prom(totPromise,partyStatus(builder,true),partyStatus(P2,false), _oath,false);
        
        unConfirmed[builder].push(totPromise);  // Pushing the promise index into the unconfirmed mapping keyed by the address
        unConfirmed[P2].push(totPromise);
        
        
        emit notify(P2,totPromise,_oath);       /*  The event is emitted, the other part gets to know about the promoise being created 
                                                    by its name as one of the involved parties   */
        return totPromise;
    }


    /*
        This function is used by the involved parties to view the promise. 
    */
    function viewPromise() public view returns(bytes32[] memory) {
        
        return pendingProm;
    }
    
    /* 
        This function is used by the other party to sign the promise and hence confirms the promise.
    */
    function signPromise(uint256 ind) public payable {
        require(msg.sender==unConfirmedProm[ind].P2.P);
        unConfirmedProm[ind].P2.commitment=true;
        unConfirmedProm[ind].status=true;
        confirmpromise(ind);
        manager.transfer(msg.value);
        
        Confirmed[msg.sender].push(ind);                    // Adding the promise to the Confirmed list of promises
        Confirmed[unConfirmedProm[ind].P1.P].push(ind);     // Adding the promise to the Confirmed list of promises
        
        // Deleting the entries from the unConfirmed mapping once the promise gets signed.
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
    
    /*
        This function is used by the non-builder party to reject the promise. 
        The promise after being rejected is added to the rejectPromise mapping. 
    */
    function rejectPromise(uint256 ind) public {
        require(msg.sender==unConfirmedProm[ind].P2.P);
        unConfirmedProm[ind].status=false;
        rejectedProm[ind]=unConfirmedProm[ind];
        Rejected[msg.sender].push(ind);                     // Insert the rejected promise into the rejected mapping
        Rejected[unConfirmedProm[ind].P1.P].push(ind);      // Insert the rejected promise into the rejected mapping
        emit notify(msg.sender,ind,unConfirmedProm[ind].oath);
        
        uint256[] memory l;                                 // Deleting the promise from unConfirmed mapping
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
    

    /* 
        This function is used to confirm promises and transfer them from unConfirmedProm to ConfirmedProm mapping.
    */
    function confirmpromise(uint256 ind) internal {
        require(msg.sender==unConfirmedProm[ind].P1.P || msg.sender==unConfirmedProm[ind].P2.P);
        require(unConfirmedProm[ind].status==true);
        ConfirmedProm[ind]=unConfirmedProm[ind];
        
    }


    /* 
        This function would be used to view the Confirmed Promises by their owner. 
    */ 
    function viewConfirmed() public view returns(uint256[] memory) {
       
       return Confirmed[msg.sender];
    }


    /* 
        This function would be used to view the Confirmed Promises by their owner. 
    */ 
    function viewRejected() public view returns(uint256[] memory) {
       
        return Rejected[msg.sender];
    }
    
    function viewUnConfirmed() public view returns(uint256[] memory) {
       
        return unConfirmed[msg.sender];
        
    }
}