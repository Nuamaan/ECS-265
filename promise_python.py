from hashlib import sha256
import json
import time


class Block:
    def __init__(self, index,promises, timestamp, previous_hash):
        self.index = index
        self.promises = promises
        self.timestamp = timestamp
        self.previous_hash = previous_hash
        self.work = 0 
        """ for proof of work; to make the digest hold leading zeros"""

    def compute_hash(self):
        
        block_string = json.dumps(self.__dict__, sort_keys=True)
        return sha256(block_string.encode()).hexdigest()


class Blockchain:
    
    

    def __init__(self,d=5):
        """ try varying d to see the differing levels of computational latency """ 
        self.difficulty=d 
        self.unconfirmed_promises = []
        self.chain = []
        self.create_zero_block()

    def create_zero_block(self):
        
        zero_block = Block(0, [], time.time(), "0")
        zero_block.hash = zero_block.compute_hash()
        self.chain.append(zero_block)

    @property
    def last_block(self):
        return self.chain[-1]

    def add_block(self, block, proof):
        
        previous_hash = self.last_block.hash 

        if previous_hash != block.previous_hash:
            return False 

        if not self.is_valid_proof(block, proof):
            return False

        block.hash = proof
        self.chain.append(block)
        return True

    def is_valid_proof(self, block, block_hash):
        """
        Check if block_hash is valid hash of block and satisfies
        the difficulty criteria.
        """
        return (block_hash.startswith('0' * self.difficulty) and
                block_hash == block.compute_hash())

    def proof_of_work(self, block):
        """
        Function that tries different values of attribute work to get a hash
        that satisfies our difficulty criteria.
        """
        block.work = 0

        computed_hash = block.compute_hash()
        while not computed_hash.startswith('0' * self.difficulty):
            block.work += 1
            computed_hash = block.compute_hash()

        return computed_hash

    def add_new_promises(self, promises):
        self.unconfirmed_promises.append(promises)

    def mine(self):
        """
        This function serves as an interface to add the pending
        transactions to the blockchain by adding them to the block
        and figuring out Proof Of Work.
        """
        if not self.unconfirmed_promises:
            print("No promise in the pool available to be added!")
            return False

        last_block = self.last_block

        new_block = Block(index=last_block.index + 1,
                          promises=self.unconfirmed_promises,
                          timestamp=time.time(),
                          previous_hash=last_block.hash)

        proof = self.proof_of_work(new_block)
        self.add_block(new_block, proof)

        self.unconfirmed_promises = []
        print(new_block.index,"indexed block mined successfully")
        
    
    def show_all_promises(self):
        for i in self.chain:
            print(i.promises)
           
        

    def show_all_hashes(self):
        for i in self.chain:
            print(i.hash)
        
    def show_all_previous_hashes(self):
        for i in self.chain:
            print(i.previous_hash)
            



a=Blockchain(5)
a.add_new_promises("A promises to give 10rs to B")
a.add_new_promises("B promises to give 10k to C")
print(a.mine())  
a.add_new_promises("N gives 77rs to Z") 
print(a.mine())

a.show_all_hashes()
a.show_all_promises()
a.show_all_previous_hashes()
