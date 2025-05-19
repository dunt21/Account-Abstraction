// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract represents a basic smart wallet that can execute transactions
contract smartWallet {
    // Address of the wallet owner
    address user;

    // Keeps track of how many times transactions have been executed (to prevent replay attacks)
    uint256 public nonce;

    // Constructor runs once when the contract is deployed
    constructor(address _owner) {
        // Set the owner of the wallet
        user = _owner;
    }

    // Modifier to make sure only the wallet owner can call certain functions
    modifier onlyOwner() {
        // Check if the caller is the owner
        require(msg.sender == user, "You're not the owner of the account");
        _;
    }

    /**
     * @dev Executes a transaction from this wallet
     * @param to The address where we want to send funds or interact with
     * @param value The amount of Ether to send
     * @param data The function call data (used for calling other contract functions)
     */
    function execute(address to, uint value, bytes calldata data) external onlyOwner {
        // Increase nonce to track the number of transactions
        nonce++;

        // Call the target contract or send Ether with the given data
        (bool success,) = to.call{value: value}(data);

        // If the call failed, revert the transaction
        require(success, "Execution fails");
    }

    /**
     * @dev Recovers the address that signed a message
     * @param hash The message hash that was signed
     * @param sig The signature (should be 65 bytes long: r + s + v)
     * @return The address of the signer
     */
    function recoverSigner(bytes32 hash, bytes memory sig) public pure returns (address) {
        // Signature must be exactly 65 bytes
        require(sig.length == 65, "Invalid signature length");

        // Declare r, s, and v components of the signature
        bytes32 r;
        bytes32 s;
        uint8 v;

        // Extract r, s, and v from the signature using inline assembly
        assembly {
            r := mload(add(sig, 32))    // First 32 bytes after the length prefix
            s := mload(add(sig, 64))    // Next 32 bytes
            v := byte(0, mload(add(sig, 96))) // Final 1 byte (first byte of next 32 bytes)
        }

        // Recover and return the signer address
        return ecrecover(hash, v, r, s);
    }

    // Special fallback function that lets the contract receive Ether
    receive() external payable { }
}

// A simple contract that logs a sponsorship (e.g., gas subsidy)
contract Paymaster {
    // Event that logs sponsorships
    event Sponsored(address user, uint256 amt);

    /**
     * @dev Sponsor a user with a given amount (no actual transfer here, just a log)
     * @param user The user being sponsored
     * @param amt The amount sponsored
     */
    function sponsor(address user, uint256 amt) external {
        emit Sponsored(user, amt);
    }
}
