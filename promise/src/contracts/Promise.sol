pragma solidity ^0.5.0;

contract Promise {
  string public name = "Promise";

  // Store Contracts
  // You will have an id (uint) for every single agreement in the blockchain, and the value of that id is the Agreement.
  // Will be stored in public variable "agreements"
  uint public agreementCount = 0;
  mapping(uint => Agreement) public agreements;

  /**
    This struct will represent the agreements stored on the blockchain.
   */

  struct Agreement
  {
    uint id;                    // An unsigned integer representing the ID.
    string hash;                // The hash value.
    string terms;               // The terms of the agreement.
    address payable contractee;   // An address that you can send Ether to. 
    address payable author;
  }

  event AgreementCreated
  (
    uint id,
    string hash,
    string terms,
    address payable contractee,
    address payable author
  );

  event AgreementAccepted
  (
    uint id,
    string hash,
    string terms,
    address payable contractee,
    address payable author
  );

  

  // Create Agreements
  function addAgreement(string memory _agreementHash, string memory _terms, address payable _author, address payable _contractee) public
  {
    // Make sure the agreement hash exits.
    require(bytes(_agreementHash).length > 0);

    // Make sure the agreement terms exist.
    require(bytes(_terms).length > 0);

    // Make sure uploader address exits
    require(msg.sender != address(0x0));

    // Increment agreement id
    agreementCount = agreementCount + 1;

    // Add agreement to contract
    agreements[agreementCount] = Agreement(agreementCount, _agreementHash, _terms, _contractee, _author);

    // Trigger an event
    emit AgreementCreated(agreementCount, _agreementHash, _terms, _contractee, _author);
  }

  // Accept Contract
  function acceptAgreement(uint _id) public payable
  {
    // Fetch the agreement
    Agreement memory _agreement = agreements[_id];

    // Fetch the author
    address payable _author = _agreement.author;

    // Pay the author Ether <= CHANGE THIS, NOT OUR FUNCTIONALITY
    address(_author).transfer(msg.value);

    // Trigger an event
    emit AgreementAccepted(agreementCount, _agreement.hash, _agreement.terms, _agreement.contractee, _author);

  }
}