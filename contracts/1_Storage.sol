// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract SimpleStorage {

    uint256 public number;

    struct People {
        string name;
        uint256 number;
    }
    People[] public people;

    /**
     * @dev Store value in variable
     * @param _number value to store
     */
    function store(uint256 _number) public virtual {
        number = _number;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
    // memory：stack var that can be edited
    // calldata：stack var that can't be edited
    // storage：heap var that can be edited
    function addPerson(string memory _name, uint256 _number) public {
        People memory person = People({
            name: _name,
            number: _number
        });
        people.push(person);
    }
}