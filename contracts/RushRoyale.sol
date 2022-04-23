// contracts/RushRoyale.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RushRoyale is ERC1155, Ownable {

    struct Pawns {
        string name;
        int8 damage;
        int8 attackSpeed;
        int8 rarity;
        int8 mintNumber;
        uint256[2] parrents;
    }

    int8 _nextId = 0;
    mapping (int256 => Pawns) _pawnDetail;

    int8 _nextCommonId = 0;
    mapping (int8 => string) _commonPawnsName;

    int8 _nextRareId = 0;
    mapping (int8 => string) _rarePawnsName;

    int8 _nextEpicId = 0;
    mapping (int8 => string) _epicPawnsName;

    int8 _nextLegendaryId = 0;
    mapping (int8 => string) _legendaryPawnsName;

    int8 _nextRarityId = 0;
    mapping (int8 => string) _rarity;

    constructor() Ownable() ERC1155("") {

    }

    function getPawnDetail(int256 tokenId) public view returns(Pawns memory) {
        return _pawnDetail[tokenId];
    }

    /*function mint() payable public returns(Pawns calldata) {

        _pawnDetail[_nextId] = Pawns("", 30, 45, 0, 0, uint256[2]([0, 0]));
        _mint(msg.sender, _nextId, 1, "");
        Pawns calldata tempPawn = _pawnDetail[_nextId];
        _nextId++;
        return tempPawn;
    }*/

    function addCommonPawn(string calldata pawnName) public onlyOwner {
        _commonPawnsName[_nextCommonId] = pawnName;
        _nextCommonId++;
    }

    function addRarePawn(string calldata pawnName) public onlyOwner {
        _rarePawnsName[_nextRareId] = pawnName;
        _nextRareId++;
    }

    function addEpicPawn(string calldata pawnName) public onlyOwner {
        _epicPawnsName[_nextEpicId] = pawnName;
        _nextEpicId++;
    }

    function addLegendaryPawn(string calldata pawnName) public onlyOwner {
        _legendaryPawnsName[_nextLegendaryId] = pawnName;
        _nextLegendaryId++;
    }

    function addRarity(string calldata rarity) public onlyOwner {
        _rarity[_nextRarityId] = rarity;
        _nextRarityId++;
    }

}