// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor{
    function getPrice() internal view returns (uint256) {
        //address : 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface dataFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = dataFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getVersion() internal view returns(uint256){
        AggregatorV3Interface dataFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return dataFeed.version();
    }

    function getConversionRate(uint256 _ethAmount)internal view returns(uint256){
        return (_ethAmount * getPrice()) / 1e18;
    }
}