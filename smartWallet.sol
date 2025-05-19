// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract smartWallet{
    address user;
    uint256 public nonce;

    constructor (address _owner){
        user = _owner;
    }

    modifier onlyOwner(){
        require(msg.sender == user, "You're not the owner of the account");
         _;
    }

    function execute(address to, uint value, bytes calldata data)  external onlyOwner {
        nonce ++;
        (bool success,) = to.call{value: value}(data);
    require(success, "Execution failes");
    } 

function recoverSigner(bytes32 hash, bytes memory sig) public pure returns (address){
    require(sig.length == 65, "Invalid signature lenght");
    bytes32 r;
    bytes32 s;
    uint8 v;
     
     assembly{
        r := mload(add(sig, 32))
        s := mload(add(sig, 64))
        v := byte(0, mload(add(sig, 96)))
     }

     return  ecrecover(hash, v, r, s);
}

receive() external payable { }

}


contract Paymaster {
    event Sponsored( address user, uint256 amt);

    function sponsor(address user, uint256 amt) external {
        emit Sponsored(user, amt);
    }
}