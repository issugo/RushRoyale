// contracts/RushRoyale.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

contract RushRoyale is ERC1155, Ownable {

    enum PawnsCommonName { ARCHER, BOMBARDIER, COLD_MAGE, FIRE_MAGE, LIGHTNING_MAGE, HUNTER, POISONER, ROGUE, THROWER }
    enum PawnsRareName { ALCHEMIST, BANNER, MAGIC_CAULDRON, PRIESTESS, SENTRY, SHARPSHOOTER, CHEMIST, GRINDSTONE, ZEALOT }
    enum PawnsEpicName { CATAPULT, GARGOYLE, PYROTECHNIC, ENGINEER, IVY, MIME, PORTAL_KEEPER, REAPER, VAMPIRE, CRYSTALMANCER, PLAGUE_DOCTOR, THUNDERER, WIND_ARCHER, EXECUTIONER, PORTAL_MAGE }
    enum PawnsLegendaryName { BLADE_DANCER, BOREAS, CORSAIR, CLOCK_OF_POWER, CULTIST, DEMON_HUNTER, DEMONOLOGIST, DRYAD, FROST, HARLEQUIN, HEX, INQUISITOR, KNIGHT_STATUE, METEOR, SHAMAN, STASIS, SUMMONER, TRAPPER }
    enum Rarity { COMMON, RARE, EPIC, LEGENDARY }

    struct Pawns {
        string name;
        int8 damage;
        int8 attackSpeed;
        Rarity rarity;
        int8 mintNumber;
        int256[2] parrents;
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

    contructor() public ERC1155("") {

    }

    function getPawnDetail(int256 tokenId) public view returns(Pawns memory) {
        return _pawnDetail[tokenId];
    }

    function mint() payable public returns() {
        _pawnDetail[_nextId] = Pawns("", 30, 45, Rarity.COMMON, 0, 0, 0);
        _mint(msg.sender, _nextId, 1, "");
        _nextId++;
    }

    function addCommonPawn(string pawnName) public onlyOwner {
        _commonPawnsName[_nextCommonId] = pawnName;
        _nextCommonId++;
    }

    function addRarePawn(string pawnName) public onlyOwner {
        _rarePawnsName[_nextRareId] = pawnName;
        _nextRareId++;
    }

    function addEpicPawn(string pawnName) public onlyOwner {
        _epicPawnsName[_nextEpicId] = pawnName;
        _nextEpicId++;
    }

    function addLegendaryPawn(string pawnName) public onlyOwner {
        _legendaryPawnsName[_nextLegendaryId] = pawnName;
        _nextLegendaryId++;
    }

}