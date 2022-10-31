// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Artist{
    address artist;

    constructor() {
        artist = msg.sender;
    }

    // Struct of Artpieces
    struct Piece{
        uint pieceId;
        address pieceOwner;
        string pieceTitle;
    }

    Piece[] public pieces;
    
    // Functions to validate that address is PieceOwner

    // Functions to transfer pieces by PieceOwner and Artist 

    // 

}