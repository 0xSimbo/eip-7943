// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.17;
import "../libraries/LibAppStorage.sol";

contract AppStorageFacet {

    function getTokenTrademarkInformation(address contractAddress) external view returns(TrademarkInformation memory) {
        return LibAppStorage.getTokenTrademarkInformation(contractAddress);
    }
    function getIsCC0(address contractAddress) external view returns(Status) {
        return LibAppStorage.getIsCC0(contractAddress);
    }
    function getIsLogoPublicDomain(address contractAddress) external view returns(Status) {
        return LibAppStorage.getIsLogoPublicDomain(contractAddress);
    }

    function getDelegateContract(address contractAddress) external view returns(address) {
        return LibAppStorage.getDelegateContract(contractAddress);
    }
    function getTrademarkDocumentLink(address contractAddress) external view returns(string memory) {
        return LibAppStorage.getTrademarkDocumentLink(contractAddress);
    }

    function setTokenTrademarkInformation(address contractAddress, TrademarkInformation memory trademarkInformation) external {
        LibAppStorage.setTokenTrademarkInformation(contractAddress,trademarkInformation);
    }

    function setIsCC0(address contractAddress, Status isCC0) external {
        LibAppStorage.setIsCC0(contractAddress,isCC0);
    }
    function setIsLogoPublicDomain(address contractAddress, Status isLogoPublicDomain) external {
       LibAppStorage.setIsLogoPublicDomain(contractAddress,isLogoPublicDomain);
    }
    function setDelegateContract(address contractAddress, address delegateContract)external {
       LibAppStorage.setDelegateContract(contractAddress,delegateContract);
    }

    function hasFullIPRights(address tokenContract,address holder,uint tokenId) external view returns(bool) {
        return LibAppStorage.hasFullIPRights(tokenContract,holder,tokenId);
    }
}