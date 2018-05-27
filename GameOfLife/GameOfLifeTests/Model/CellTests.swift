//
//  CellTests.swift
//  GameOfLifeTests
//
//  Created by Karen Pinzás Morrongiello on 5/11/18.
//  Copyright © 2018 Karen Pinzás Morrongiello. All rights reserved.
//

import XCTest
@testable import GameOfLife

class CellTests: XCTestCase {
    
    func testCellCreation() {
        let cell = Cell(x: 0, y: 0)
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.currentState, .neverBorn)
    }
    
    func testWhenTwoCellsAreEqual() {
        let firstCell = Cell(x: 1, y: 0)
        let secondCell = Cell(x: 1, y: 0)
        XCTAssertTrue(firstCell == secondCell)
    }
    
    func testWhenTwoCellsAreDifferent() {
        let firstCell = Cell(x: 1, y: 0)
        let secondCell = Cell(x: 1, y: 1)
        XCTAssertFalse(firstCell == secondCell)
    }
    
    func testWhenTwoCellsAreDifferentBecauseState() {
        let firstCell = Cell(x: 1, y: 1)
        firstCell.currentState = .permanentlyDead
        
        let secondCell = Cell(x: 1, y: 1)
        secondCell.currentState = .dead
        
        XCTAssertFalse(firstCell == secondCell)
    }
}
