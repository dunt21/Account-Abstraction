#Account Abstraction

Its a concept in solidity that allows a contract to act has a wallet without the need of a private key and it also guarantees a recovery method using any account of the users choice. Also the user can create this smart account with just a phone number and email or even a web3 wallet making it seamless and less cumbersome.

It differs from EOA model because there's no private key used to sign a transaction, you can recover your account when its lost, at times the gas fees are covers saving the users from paying any transaction cost and it also supports multi-signature.

**Bundler** : It gathers many user operations and bundles them as one, then transfers them to the entry point.

**Entry Point**: It executes the user operations by making sure every thing is valid then carries on to perform the required actions.

**Paymaster**: This is a contract that covers the gas fees for the user.

**User operation**: Its a data structure that holds all the information of the transaction made by the user.

**Security Implications**
- Users fund could be of risk if there's a bug in the system
- Complex logic can be difficult to maintain, understand and worked upon.

**Mitigations**
- Utilising well trusted libraries like OpenZeppelin
- Introduce nonce in user operations to prevent repetition of operations.

**How paymaster enables gasless transactions**
It recieves the user operation and checks if its meant to cover the gas fees, if it supposed to do so, it signs the transaction for the user and pays the transaction cost for that operation.

**Why it matters**
It makes using web3 applications easier and user friendly without causing worry of how to get tokens to cover for gas fees. It also great for onboarding people new to web3 using Dapps intergrated with the paymaster.

