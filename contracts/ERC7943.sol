// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;
import "./interfaces/IERC7943.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
 
/// @author 0xSimon)
 
contract ERC1111  is IERC7943,ERC721{
    TrademarkInformation private trademarkInformation = TrademarkInformation({
        isCC0:false,
        isLogoPublicDomain:false,
        trademarkDocumentLink:"https://project-xyz.io/ip_agreement"
    });
    constructor(string memory name, string memory symbol)
 
    ERC721(name,symbol)
    {}
    function hasFullIPRights(address holder, uint tokenId) external view virtual override returns(bool){
        return  holder == ownerOf(tokenId);
    }
    function getTrademarkInformation() external view  virtual override returns(TrademarkInformation memory) {
        return trademarkInformation;
    }
    function updateTrademarkInformation(TrademarkInformation memory newTrademarkInformation) external virtual override {
        trademarkInformation = newTrademarkInformation;
        emit UpdatedPolicy(block.timestamp,newTrademarkInformation);
 
    }
 
    function supportsInterface(bytes4 interfaceId) public view virtual override returns(bool) {
        return interfaceId == type(IERC7943).interfaceId || super.supportsInterface(interfaceId);
    }
 
}
