// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;
import "./1_Storage.sol";
contract ExtraStorage is SimpleStorage {
    function store(uint256 _number) public override  {
        number = _number + 5;
    }
} 