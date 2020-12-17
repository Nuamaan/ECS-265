# Promise Dapp

Install Truffle Suite's Ganache and Metamask.

## Environment setup
Once installed, use Ganache's Quickstart or create your own workspace. 
Set up Metamask in Google Chrome or Mozilla Firefox and create a Custom RPC with:
- Network Name: localhost 9545
- New RPC URL: http://127.0.0.1:9545
- Chain ID: 0x539

Once the network is added, import the first few Ganache accounts into Metamask using the provided private keys for each account. The balance of each account in Ganache should now match the corresponding account balances in Metamask.

## Smart contract compilation and deployment
Compile and deploy the smart contract on your local blockchain. 
```
truffle compile
truffle migrate --reset
```
The first account balance should have decreased slightly in Ganache after deployment.

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

## View the project
Copy and paste the localhost link to your web browser and view the decentralized web application!

## More Metamask setup
Connect the localhost site to each of the imported accounts in Metamask. After doing so, each account in Metamask should display a green circle on the top left that says 'Connected'. 

## Set up complete!
You are all set to use our web application!

Notes: 
- Make sure to refresh the browser each time you switch Metamask accounts to view the correct information. 
- If you are writing a contract, remember to switch back to your own Metamask account before clicking the 'Submit' button.

## Contributors
Ikechi Iwuagwu: 912684323, jiiwuagwu@ucdavis.edu\
Agnieszka Lupinska: 916670964, alupinska@ucdavis.edu\
Nuamaan Sheikh: 918940663, nisheikh@ucdavis.edu\
Alicia Siu: 914005515, aclsiu@ucdavis.edu