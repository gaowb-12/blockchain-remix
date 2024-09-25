// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

// solhint-disable-next-line interface-starts-with-i
import "./5_priceConverter.sol";

error NotOwner();

// 1. get funds from users
// 2. withdraw funds
// 3. set a minimum funding value in USD
contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // record funders
    address[] public funders;
    // record sended funds of Address
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund( ) public payable{
        // want to be able to set a minimum fund amount in USD
        // 1. how do we send ETH to this contract?
        // msg.value is calculated in ETH
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!"); // set condition and if condition is not right, revert
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // what is reverting?  --> undo any antion before, and send remaining gas back
    }
    
    // how do we change USD to ETH? -->需要预言机，为了获得以太币的美元价格，需要从区块链之外获得信息
    
    function withdraw() public onlyOwner {
        
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            // reset sender mapping
            addressToAmountFunded[funder] = 0;
        }
        // reset address Array
        funders = new address[](0);
        // Actually withdraw the funds
        // transfer send call

        // 1. transfer 2300gas
        // msg.sender = address
        // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance); // auto rollback

        // 2. send 2300gas
        // bool sendSuccess = payable(msg.sender).send(address(this).balance); // not auto rollback
        // require(sendSuccess, "Send Failed"); // rollback by require function

        // 2. call 接触到的第一个比较底层的命令，通过call可以几乎调用所有solidity的函数
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); 
        require(callSuccess, "Call Failed"); // rollback by require function
        revert();

    }
    modifier onlyOwner(){
        // require(msg.sender == i_owner, "Sender is not Owner");
        if(msg.sender != i_owner){ revert NotOwner(); }
        _;
    } 
    // what happens if someone sends this contract ETH without calling the fund function
    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
}