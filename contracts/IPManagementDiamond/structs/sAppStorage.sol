// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import {TrademarkInformation} from "./TrademarkInformation.sol";
struct AppStorage {
    mapping(address => TrademarkInformation) trademarkInformation;
    mapping(address => string) trademarkDocumentLink;
}