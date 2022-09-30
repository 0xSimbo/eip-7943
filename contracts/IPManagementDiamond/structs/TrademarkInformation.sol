// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


enum Status {
    NOT_SET,
    FALSE,
    TRUE
}
struct TrademarkInformation {
    Status isCC0;
    Status isLogoPublicDomain;
    address delegateContract;
}