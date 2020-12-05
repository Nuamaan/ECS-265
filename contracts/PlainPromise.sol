// pragma solidity ^0.5.1;
pragma solidity >=0.4.22 <0.8.0;

contract PlainPromise
{
    uint256 public totalPromiseCount;              // The total count of the promises that have been created - used to index the promises. Default is 0.
    address payable manager;
    mapping(uint256=>Promise) pendingPromises;     // This mapping holds unconfirmed promises initially before they are signed by the participating parties.
    mapping(uint256=>Promise) signedPromises;      // This mapping holds signed promises after they are signed by the participating parties.
    mapping(uint256=>Promise) rejectedPromises;    // This mapping holds rejected promises after they are rejected by the participating promises.
    
    // Each address will have an individual array of promises associated with it. ----- Below
    // Each mapping is called an archive.

    mapping(address=>uint256[]) signedArchive;      // This mapping maps each address to an individual array of signed promises for it.
    mapping(address=>uint256[]) rejectedArchive;    // This mapping maps each address to an individual array of rejected promises for it.
    mapping(address=>uint256[]) pendingArchive;     // This mapping maps each address to an individual array of pending contracts for it.


    /**
     * Constructor
     */

    constructor() public 
    {
        manager = msg.sender;
    }

    /**
     * Modifier
     * Modifiers can be used to change the behaviour of functions in a declarative way.
     * This modifier checks to make sure the sender is the manager before executing the function. 
     */

    modifier isManager()
    {
        require(msg.sender == manager);
        _;
    }

    
    /* This event notifies the other participating party of the promise that has been created.*/
    event notify(
        address recipientAccount,
        uint256 promiseIndex,
        string oathTitle,
        string oath
    );
    
    /* This struct holds the account address of an individual along with their commitment status.*/
    struct partyStatus
    {  
        address accountAddress;
        bool commitmentStatus;
    }
    
    /*A structure that represents our Promise, it contains the index, commitment statuses of the participating parties, and a bool status. */
    struct Promise 
    {
        uint256 promiseIndex;
        partyStatus builderAccount;
        partyStatus recipientAccount;
        string oathTitle;   // The title of the contract.
        string oath;        // The terms of the contract.
        bool status;
    }
   
    /**
     * This function is used to create a promise. After the builder creates the contract,
     * it will be added to the pendingContracts mapping of the creator and the recipient.
     * This function will fail unless the account entered as builder is the same account that 
     * is creating the promise.
     * @param builder The address of the creator.
     * @param recipient The address of the recipient.
     * @param _oathTitle The title of the contract.
     * @param _oath The contacts of the contract.
     * @return The total count of promises.
     */

     function addPromise(address builder, address recipient, string memory _oathTitle, string memory _oath) public payable returns(uint256){ 
        
        // When calling the function, require builder to be the person who is creating contract.
        require(msg.sender == builder);
        
        //require(msg.value==2 e);
        manager.transfer(msg.value);       // Ethers are passed to the manager,,,calling addPromise function would cost the builder.

        totalPromiseCount++;               // Increment the total promise count by 1. 
       // pendingProm.push(_oath);

        /**
         * pendingPromises is a mapping. What this function does is add the newly created promise to the pendingPromises mapping 
         * while using the totalPromiseCount as an index.
         * The Promise Constructor accepts 6 arguments.
         * 1. promiseIndex (which will be the total PromiseCount)
         * 2. The partystatus of the contract creator.
         * 3. The partstatus of the recipient.
         * 4. The title of the contract.
         * 5. The contents of the contract.
         * 6. The status of the contract. (Not sure what this is).
         * Question: In order to use the the 0 index, why don't we just add 1 to the totalPromiseCount AFTER we add to pendingPromises?
         */

        /*
        partyStatus builderPartyStatus = partyStatus(builder, true);    // The status of the first user is true because they are the one who created it.
        partyStatus recipientPartyStatus = partyStatus(builder, false); // The status of the second user is false because they haven't yet signed it.
        pendingPromises[totalPromiseCount] = Promise(totalPromiseCount, builderPartyStatus, recipientPartyStatus, _oath, false);
        */
        pendingPromises[totalPromiseCount] = Promise(totalPromiseCount, partyStatus(builder, true), partyStatus(recipient, false),_oathTitle, _oath, false);


        /**
         * The following code adds the pending promise to the pending archive of both the contract creator and recipient.
         * This mapping associates each address with an individual array of itself that will hold all of their contracts.
         */

        pendingArchive[builder].push(totalPromiseCount); // pushing the promise index into the unconfirmed  mapping keyed by the address.
        pendingArchive[recipient].push(totalPromiseCount);

        
        
        
        // After the promises have been added to the respective arrays and mapping, emit event to signal to recipient.
        emit notify(recipient, totalPromiseCount, _oathTitle, _oath); 
                
        return totalPromiseCount;
        
    }

    /**
     * This function is used by the involved parties in order to view the contents of the contract.
     * This function will fail if a user not involved with the contract attempts to view it by using index.
     * @param index The index of promise that is within the pendingPromises mapping.
     * @return The contents of the promise.
     */

     function viewPromise(uint256 index) public view returns(string memory)
     { 
        require(msg.sender == pendingPromises[index].builderAccount.accountAddress || msg.sender == pendingPromises[index].recipientAccount.accountAddress);
        return pendingPromises[index].oath;
    }

    /**
     * This function is used by the involved parties in order to view the title of the contract.
     * This function will fail if a user not involved with the contract attempts to view it by using index.
     * @param index The index of promise that is within the pendingPromises mapping.
     * @return The contents of the promise.
     */

     function viewPromiseTitle(uint256 index) public view returns(string memory)
     { 
        require(msg.sender == pendingPromises[index].builderAccount.accountAddress || msg.sender == pendingPromises[index].recipientAccount.accountAddress);
        return pendingPromises[index].oathTitle;
    }

    
    /**
     * This function is used by the recipient party in order to sign and confirm the promise.
     * This function will fail if a party not involved with the contract attempts to sign it by using its index.
     * @param index The index of the promise in the pendingPromises mapping.
     */

    function signPromise(uint256 index) public payable 
    {
        // Require the caller of this function to be recipient of the contract.
        require(msg.sender == pendingPromises[index].recipientAccount.accountAddress);
      

        // Change the commitment status of the recipient to true for this particular promise.
        pendingPromises[index].recipientAccount.commitmentStatus = true;
        pendingPromises[index].status = true;   
        confirmPromise(index);
        manager.transfer(msg.value);
        
        // Add the index of this promise to the signed archive of recipient.
        signedArchive[msg.sender].push(index);    

        // Add the index of this promise to the signed archive of creator.                                        
        signedArchive[pendingPromises[index].recipientAccount.accountAddress].push(index); 
        
        
        // After the promise is signed and added to signedArchive, we remove it from the pendingArchive.

        // userPromises holds all of the pendingPromises of one individual user in an array.
        // pendingArchive holds all the pendingPromises arrays for all users.
        uint256[] memory userPromises;
        userPromises = pendingArchive[msg.sender];


        // Find the promise in the recipient's list of pending promises and delete it.
        for (uint index2; index2 < userPromises.length; index2++)
        {
            if (userPromises[index2] == index)
                delete pendingArchive[msg.sender][index2];
        }


        // Find the promise in the contract creator's list of pending promises and delete it.
        userPromises = pendingArchive[pendingPromises[index].builderAccount.accountAddress];
        for(uint index2; index2 < userPromises.length; index2++)
        {
            if (userPromises[index2] == index)
                delete pendingArchive[pendingPromises[index].builderAccount.accountAddress][index2];
        }
    }
    
    /**
     * This function is used by the recipient in order to reject the promise.
     * After the promise is rejected it is added to the rejectedPromises mapping.
     * This function will fail if it is called by an account that is not the recipient to the promise.
     * @param index The index of the promise in the pendingPromises mapping.
     */

    function rejectPromise(uint256 index) public  
    {
        require(msg.sender == pendingPromises[index].recipientAccount.accountAddress);

        pendingPromises[index].status = false;                  // Set the status of this promise to false.
        rejectedPromises[index] = pendingPromises[index];       // Add this promise to the rejectPromises mapping at the exact same index?
        rejectedArchive[msg.sender].push(index);                 // Add the index of this promise to the array of rejectedPromises for this user.
        rejectedArchive[pendingPromises[index].builderAccount.accountAddress].push(index);  // Add the index of this promise to the array of rejectedPromises for creator.
        
        emit notify(msg.sender, index, pendingPromises[index].oathTitle, pendingPromises[index].oath);
        

        // Find the promise in the recipient's list of pending promises and delete it.
        uint256[] memory userPromises;
        userPromises = pendingArchive[msg.sender];

        for (uint index2; index2 < userPromises.length; index2++)
        {
            if (userPromises[index2] == index)
                delete pendingArchive[msg.sender][index2];
        }
        
        // Find the promise in the contract creator's list of pending promises and delete it.
        userPromises = pendingArchive[pendingPromises[index].builderAccount.accountAddress];
        for(uint index2; index2 < userPromises.length; index2++)
        {
            if (userPromises[index2] == index)
                delete pendingArchive[pendingPromises[index].builderAccount.accountAddress][index2];
        }
    }
    
    /**
     * This function confirms promises and transfers them to the signedPromises mapping.
     * This function fails if it is called by a user not involved in the contract.
     * @param index The index of the promise in the pendingPromise mapping.
     */
    function confirmPromise(uint256 index) internal 
    {
        require(msg.sender == pendingPromises[index].builderAccount.accountAddress || msg.sender == pendingPromises[index].recipientAccount.accountAddress);
        require(pendingPromises[index].status == true);

        signedPromises[index] = pendingPromises[index];   // Add the signed promise at the exact same index as the pending promise was?
        
    }

  
    /**
     * This function returns an array containing all of the signed promises for one user.
     * @return An array containing all signedContracts for user.
     */
    function viewSignedPromises() public view returns(uint256[] memory)
    {
       return signedArchive[msg.sender];
    }

    /**
     * This function returns an array containing all of the rejected promises for one user.
     * @return An array containing all signedContracts for user.
     */
    function viewRejectedPromises() public view returns(uint256[] memory)
    {   
        return rejectedArchive[msg.sender];
    }
    
    /**
     * This function returns an array containing all of the pending promises for one user.
     * @return An array containing all signedContracts for user.
     */
    function viewPendingPromises() public view returns(uint256[] memory)
    {    
        return pendingArchive[msg.sender];   
    }
    
}