// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

// solhint-disable-next-line interface-starts-with-i
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // get Price from chainlink
    function getPrice() internal view returns(uint256) {
        // ABI
        // Address 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
        (   /* uint80 roundID */,
            int256 answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
         ) =  priceFeed.latestRoundData();
        // BTC in terms of USD
        return uint256(answer * 1e10);
    }
    function getVersion() internal view returns(uint256){
        return AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43).version();
    }
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}