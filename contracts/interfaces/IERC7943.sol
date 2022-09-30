// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

/// @author 0xSimon_
struct TrademarkInformation {
    bool isCC0;
    bool isLogoPublicDomain;
    string trademarkDocumentLink;
}
interface IERC7943{
    event UpdatedPolicy(uint indexed timestamp,TrademarkInformation trademarkInformation);

    function hasFullIPRights(address holder, uint tokenId) external view returns(bool);
    function getTrademarkInformation() external view returns(TrademarkInformation memory);
    function updateTrademarkInformation(TrademarkInformation memory newTrademarkInformation) external;

}
    // function isCC0() external view returns(bool);
    // function isLogoPublicDomain() external view returns(bool);
    // function extraIPInformation() external view returns(string memory);
    // function setExtraIPInformation(string memory url) external;