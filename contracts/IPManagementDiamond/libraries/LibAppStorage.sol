// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.17;   
import {AppStorage} from "../structs/sAppStorage.sol";
import {TrademarkInformation} from "../structs/TrademarkInformation.sol";
import {Status} from "../structs/TrademarkInformation.sol";
error DoesNotSupportIERC721();
error NotERC721Owner();
error DelegateContractNotSet();
///@author @0xSimon_
library LibAppStorage {
    bytes4 internal constant IERC721_INTERFACE_ID = 0x80ac58cd;
    bytes32 internal constant NAMESPACE = keccak256("ip.management.appstorage");

       function appStorage() internal pure returns(AppStorage storage s)  {
        bytes32 position = NAMESPACE;
        assembly{
            s.slot := position
        }
    }

    function getTokenTrademarkInformation(address contractAddress) internal view returns(TrademarkInformation memory) {
        AppStorage storage s = appStorage();
        return  s.trademarkInformation[contractAddress];
    }
    function getIsCC0(address contractAddress) internal view returns(Status) {
        AppStorage storage s = appStorage();
        return s.trademarkInformation[contractAddress].isCC0;
    }
    function getIsLogoPublicDomain(address contractAddress) internal view returns(Status) {
        AppStorage storage s = appStorage();
        return s.trademarkInformation[contractAddress].isLogoPublicDomain;
    }

    function getDelegateContract(address contractAddress) internal view returns(address) {
        AppStorage storage s = appStorage();
        address delegateAddress = s.trademarkInformation[contractAddress].delegateContract;
        if(delegateAddress == address(0)) revert DelegateContractNotSet();
        return delegateAddress;
    }
    function getTrademarkDocumentLink(address contractAddress) internal view returns(string memory) {
        AppStorage storage s = appStorage();
        return s.trademarkDocumentLink[contractAddress];
    }

    function setTokenTrademarkInformation(address contractAddress, TrademarkInformation memory trademarkInformation) internal {
        AppStorage storage s = appStorage();
        if(!MinimalOwnableIERC721(contractAddress).supportsInterface(IERC721_INTERFACE_ID)) revert DoesNotSupportIERC721();
        if(msg.sender != MinimalOwnableIERC721(contractAddress).owner()) revert NotERC721Owner();
        s.trademarkInformation[contractAddress] = trademarkInformation;
    }

    function setIsCC0(address contractAddress, Status isCC0) internal {
        AppStorage storage s = appStorage();
        if(!MinimalOwnableIERC721(contractAddress).supportsInterface(IERC721_INTERFACE_ID)) revert DoesNotSupportIERC721();
        if(msg.sender != MinimalOwnableIERC721(contractAddress).owner()) revert NotERC721Owner();
        s.trademarkInformation[contractAddress].isCC0 = isCC0;
    }
    function setIsLogoPublicDomain(address contractAddress, Status isLogoPublicDomain) internal {
        AppStorage storage s = appStorage();
        if(!MinimalOwnableIERC721(contractAddress).supportsInterface(IERC721_INTERFACE_ID)) revert DoesNotSupportIERC721();
        if(msg.sender != MinimalOwnableIERC721(contractAddress).owner()) revert NotERC721Owner();
        s.trademarkInformation[contractAddress].isLogoPublicDomain = isLogoPublicDomain;
    }
    function setDelegateContract(address contractAddress, address delegateContract)internal {
        AppStorage storage s = appStorage();
        if(!MinimalOwnableIERC721(contractAddress).supportsInterface(IERC721_INTERFACE_ID)) revert DoesNotSupportIERC721();
        if(msg.sender != MinimalOwnableIERC721(contractAddress).owner()) revert NotERC721Owner();
        s.trademarkInformation[contractAddress].delegateContract = delegateContract;
        }

    function hasFullIPRights(address tokenContract,address holder,uint tokenId) internal view returns(bool) {
        AppStorage storage s = appStorage();
        //If tokenContract Supports The Interface
        if(MinimalOwnableIERC721(tokenContract).supportsInterface(IERC721_INTERFACE_ID)) {
            return MinimalIERC7943(tokenContract).hasFullIPRights(holder,tokenId);
        }
        address delegateContract = s.trademarkInformation[tokenContract].delegateContract;
        return MinimalIERC7943(delegateContract).hasFullIPRights(holder,tokenId);
    }

    
}
interface MinimalOwnableIERC721 {
    function owner() external view returns(address);
    function ownerOf(uint tokenId) external view returns(address);
    function supportsInterface(bytes4 interfaceId) external view returns(bool);
}
interface MinimalIERC7943{
    function hasFullIPRights(address holder,uint tokenId) external view returns(bool);
}