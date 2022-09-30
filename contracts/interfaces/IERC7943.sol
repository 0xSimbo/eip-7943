// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;


///@author Twitter: @0xSimon_


enum Status {
    NOT_SET,
    FALSE,
    TRUE
}
struct TrademarkInformation {
    Status isCC0;
    Status isLogoPublicDomain;
    string trademarkDocumentLink;
}
interface IERC7943{
    event UpdatedPolicy(uint indexed timestamp,TrademarkInformation trademarkInformation);

    function hasFullIPRights(address holder, uint tokenId) external view returns(bool);
    function getTrademarkInformation() external view returns(TrademarkInformation memory);
    function updateTrademarkInformation(TrademarkInformation memory newTrademarkInformation) external;

}
