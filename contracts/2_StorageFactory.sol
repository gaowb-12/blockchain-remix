// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "./1_Storage.sol";

/**
 * @title Owner
 * @dev Set & change owner
 */
contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address
        // ABI Application Binary Interface
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

} 
