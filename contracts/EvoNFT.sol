// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EvoNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    struct EvolutionStage {
        uint256 timestamp;
        string tokenURI;
    }

    mapping(uint256 => EvolutionStage[]) public tokenEvolution;

    constructor() ERC721("EvoNFT", "EVT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    function mintNFT(string memory initialURI) external onlyOwner returns (uint256) {
        uint256 newTokenId = tokenCounter;
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, initialURI);
        tokenEvolution[newTokenId].push(EvolutionStage(block.timestamp, initialURI));
        tokenCounter += 1;
        return newTokenId;
    }

    function evolveToken(uint256 tokenId, string memory newURI) external onlyOwner {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        _setTokenURI(tokenId, newURI);
        tokenEvolution[tokenId].push(EvolutionStage(block.timestamp, newURI));
    }

    function getEvolutionHistory(uint256 tokenId) external view returns (EvolutionStage[] memory) {
        return tokenEvolution[tokenId];
    }
}