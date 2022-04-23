// contracts/Merging.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Merging is ERC1155, Ownable {

    struct Dot {
        string color;
        int8 level;
    }

    uint256 _nextId = 0;
    mapping(uint256 => Dot) _dotDetails;

    mapping(uint256 => string) _dotColors;

    constructor() ERC1155("") {
        _dotColors[0] = "Red";
        _dotColors[1] = "Green";
        _dotColors[2] = "Blue";
        _dotColors[3] = "Yellow";
        _dotColors[4] = "Purple";
        _dotColors[5] = "Orange";
        _dotColors[6] = "Pink";
        _dotColors[7] = "Brown";
        _dotColors[8] = "White";
        _dotColors[9] = "Black";
        _dotColors[10] = "Gray";
    }

    function getDotDetail(uint256 tokenId) public view returns(Dot memory) {
        return _dotDetails[tokenId];
    }

    function mint() payable public returns(Dot memory) {
        _dotDetails[_nextId] = Dot(_dotColors[random()%11], 0);
        _mint(msg.sender, _nextId, 1, "");
        Dot memory tempDot = _dotDetails[_nextId];
        _nextId++;
        return tempDot;
    }

    function merge(uint256 tokenId1, uint256 tokenId2) public {
        Dot memory dot1 = _dotDetails[tokenId1];
        Dot memory dot2 = _dotDetails[tokenId2];
        require(balanceOf(msg.sender, tokenId1) < 1, "first token is not yours");
        require(balanceOf(msg.sender, tokenId2) < 1, "second token is not yours");
        require(dot1.level == dot2.level, "Cannot merge two dots with different levels");
        require(compareStrings(dot1.color, dot2.color), "Cannot merge two dots with different colors");
        _mint(msg.sender, _nextId, 1, "");
        _nextId++;
        _burn(msg.sender, tokenId1, 1);
        _burn(msg.sender, tokenId2, 1);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, _nextId)));
    }

    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}