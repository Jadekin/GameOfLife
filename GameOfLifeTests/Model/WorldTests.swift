//
//  WorldTests.swift
//  GameOfLifeTests
//
//  Created by Karen Pinzás Morrongiello on 5/11/18.
//  Copyright © 2018 Karen Pinzás Morrongiello. All rights reserved.
//

import XCTest
@testable import GameOfLife

class WorldTests: XCTestCase {
    
    func testWorldInit() {
        let world = World(withDimension: 20)
        XCTAssertNotNil(world)
    }
    
    func testNumberOfCreatedCells() {
        let world = World(withDimension: 20)
        XCTAssertNotNil(world.getCellWith(x: 0, y: 0))
        XCTAssertEqual(world.cells.count, 400)
    }
    
    func testIfTwoCellsAreNeighbours() {
        let world = World(withDimension: 20)
        guard let firstCell = world.getCellWith(x: 5, y: 6), let secondCell = world.getCellWith(x: 6, y: 6) else {
            XCTFail()
            return
        }
        XCTAssertTrue(world.areNeighbours(cell1: firstCell, cell2: secondCell))
    }
    
    func testIfTwoCellsAreNOTNeighbours() {
        let world = World(withDimension: 3)
        guard let firstCell = world.getCellWith(x: 2, y: 2), let secondCell = world.getCellWith(x: 2, y: 0) else {
            XCTFail()
            return
        }
        XCTAssertFalse(world.areNeighbours(cell1: firstCell, cell2: secondCell))
    }
    
    func testGetNeighboursForCellWhenItIsInTheMiddle() {
        let world = World(withDimension: 20)
        guard let cell = world.getCellWith(x: 5, y: 6) else {
            XCTFail()
            return
        }
        
        let neighbours = world.getNeighboursFor(cell)
        let listToCheckNeighbours = [
            Cell(x: 4, y: 5),
            Cell(x: 4, y: 6),
            Cell(x: 4, y: 7),
            
            Cell(x: 5, y: 5),
            Cell(x: 5, y: 7),
            
            Cell(x: 6, y: 5),
            Cell(x: 6, y: 6),
            Cell(x: 6, y: 7)
        ]
        XCTAssertEqual(neighbours, listToCheckNeighbours)
    }
    
    func testGetNeighboursForCellWhenTheCellIsLocatedInTheBorder() {
        let world = World(withDimension: 3)
        guard let cell = world.getCellWith(x: 0, y: 0) else {
            XCTFail()
            return
        }
        
        let neighbours = world.getNeighboursFor(cell)
        let listToCheckNeighbours = [
            Cell(x: 0, y: 1),
            Cell(x: 1, y: 0),
            Cell(x: 1, y: 1)
        ]
        XCTAssertEqual(neighbours, listToCheckNeighbours)
    }

    func getCellWith(x: Int, y: Int, currentState: CellState) -> Cell {
        let cell = Cell(x: x, y: y)
        cell.currentState = currentState
        return cell
    }

    func testWhenALivingCellDiesBecauseItHasOneOrLessNeighbors() {
        let world = World(withDimension: 3)
        world.getCellWith(x: 0, y: 0)?.currentState = .dead
        world.getCellWith(x: 0, y: 1)?.currentState = .alive
        world.getCellWith(x: 0, y: 2)?.currentState = .dead
        world.getCellWith(x: 1, y: 0)?.currentState = .dead
        world.getCellWith(x: 1, y: 1)?.currentState = .alive
        world.getCellWith(x: 1, y: 2)?.currentState = .dead
        world.getCellWith(x: 2, y: 0)?.currentState = .dead
        world.getCellWith(x: 2, y: 1)?.currentState = .alive
        world.getCellWith(x: 2, y: 2)?.currentState = .dead

        world.checkCellsStates()

        let resultCells: [Cell] = [
            getCellWith(x: 0, y: 0, currentState: .dead),
            getCellWith(x: 0, y: 1, currentState: .dead),
            getCellWith(x: 0, y: 2, currentState: .dead),
            getCellWith(x: 1, y: 0, currentState: .alive),
            getCellWith(x: 1, y: 1, currentState: .alive),
            getCellWith(x: 1, y: 2, currentState: .alive),
            getCellWith(x: 2, y: 0, currentState: .dead),
            getCellWith(x: 2, y: 1, currentState: .dead),
            getCellWith(x: 2, y: 2, currentState: .dead)
        ]
        
        XCTAssertEqual(world.cells, resultCells)
    }
    
    func testWhenALivingCellDiesBecauseItHasFourOrMoreNeighbors() {
        let world = World(withDimension: 3)
        world.getCellWith(x: 0, y: 0)?.currentState = .alive
        world.getCellWith(x: 0, y: 1)?.currentState = .dead
        world.getCellWith(x: 0, y: 2)?.currentState = .alive
        world.getCellWith(x: 1, y: 0)?.currentState = .dead
        world.getCellWith(x: 1, y: 1)?.currentState = .alive
        world.getCellWith(x: 1, y: 2)?.currentState = .dead
        world.getCellWith(x: 2, y: 0)?.currentState = .alive
        world.getCellWith(x: 2, y: 1)?.currentState = .dead
        world.getCellWith(x: 2, y: 2)?.currentState = .alive
        
        world.checkCellsStates()
        
        let resultCells: [Cell] = [
            getCellWith(x: 0, y: 0, currentState: .dead),
            getCellWith(x: 0, y: 1, currentState: .alive),
            getCellWith(x: 0, y: 2, currentState: .dead),
            getCellWith(x: 1, y: 0, currentState: .alive),
            getCellWith(x: 1, y: 1, currentState: .dead),
            getCellWith(x: 1, y: 2, currentState: .alive),
            getCellWith(x: 2, y: 0, currentState: .dead),
            getCellWith(x: 2, y: 1, currentState: .alive),
            getCellWith(x: 2, y: 2, currentState: .dead)
        ]
        
        XCTAssertEqual(world.cells, resultCells)
    }
    
    func testWhenALivingCellStilLivesBecauseItHasTwoOrThreeNeighbors() {
        let world = World(withDimension: 3)
        world.getCellWith(x: 0, y: 0)?.currentState = .dead
        world.getCellWith(x: 0, y: 1)?.currentState = .dead
        world.getCellWith(x: 0, y: 2)?.currentState = .dead
        world.getCellWith(x: 1, y: 0)?.currentState = .dead
        world.getCellWith(x: 1, y: 1)?.currentState = .alive
        world.getCellWith(x: 1, y: 2)?.currentState = .alive
        world.getCellWith(x: 2, y: 0)?.currentState = .dead
        world.getCellWith(x: 2, y: 1)?.currentState = .alive
        world.getCellWith(x: 2, y: 2)?.currentState = .alive
        
        world.checkCellsStates()
        
        let resultCells: [Cell] = [
            getCellWith(x: 0, y: 0, currentState: .dead),
            getCellWith(x: 0, y: 1, currentState: .dead),
            getCellWith(x: 0, y: 2, currentState: .dead),
            getCellWith(x: 1, y: 0, currentState: .dead),
            getCellWith(x: 1, y: 1, currentState: .alive),
            getCellWith(x: 1, y: 2, currentState: .alive),
            getCellWith(x: 2, y: 0, currentState: .dead),
            getCellWith(x: 2, y: 1, currentState: .alive),
            getCellWith(x: 2, y: 2, currentState: .alive)
        ]
        
        XCTAssertEqual(world.cells, resultCells)
    }
    
    func testWhenADeadCellLivesBecauseItHasThreeNeighbors() {
        let world = World(withDimension: 3)
        world.getCellWith(x: 0, y: 0)?.currentState = .dead
        world.getCellWith(x: 0, y: 1)?.currentState = .dead
        world.getCellWith(x: 0, y: 2)?.currentState = .dead
        world.getCellWith(x: 1, y: 0)?.currentState = .alive
        world.getCellWith(x: 1, y: 1)?.currentState = .alive
        world.getCellWith(x: 1, y: 2)?.currentState = .dead
        world.getCellWith(x: 2, y: 0)?.currentState = .dead
        world.getCellWith(x: 2, y: 1)?.currentState = .alive
        world.getCellWith(x: 2, y: 2)?.currentState = .dead
        
        world.checkCellsStates()
        
        let resultCells: [Cell] = [
            getCellWith(x: 0, y: 0, currentState: .dead),
            getCellWith(x: 0, y: 1, currentState: .dead),
            getCellWith(x: 0, y: 2, currentState: .dead),
            getCellWith(x: 1, y: 0, currentState: .alive),
            getCellWith(x: 1, y: 1, currentState: .alive),
            getCellWith(x: 1, y: 2, currentState: .dead),
            getCellWith(x: 2, y: 0, currentState: .alive),
            getCellWith(x: 2, y: 1, currentState: .alive),
            getCellWith(x: 2, y: 2, currentState: .dead)
        ]
        
        XCTAssertEqual(world.cells, resultCells)
    }
    
    func testWhenADeadCellBecomesPermanentlyDeadBecauseItHasFourOrMoreNeighbors() {
        let world = World(withDimension: 3)
        world.getCellWith(x: 0, y: 0)?.currentState = .alive
        world.getCellWith(x: 0, y: 1)?.currentState = .alive
        world.getCellWith(x: 0, y: 2)?.currentState = .dead
        world.getCellWith(x: 1, y: 0)?.currentState = .alive
        world.getCellWith(x: 1, y: 1)?.currentState = .dead
        world.getCellWith(x: 1, y: 2)?.currentState = .dead
        world.getCellWith(x: 2, y: 0)?.currentState = .dead
        world.getCellWith(x: 2, y: 1)?.currentState = .alive
        world.getCellWith(x: 2, y: 2)?.currentState = .dead

        world.checkCellsStates()

        let resultCells: [Cell] = [
            getCellWith(x: 0, y: 0, currentState: .alive),
            getCellWith(x: 0, y: 1, currentState: .alive),
            getCellWith(x: 0, y: 2, currentState: .dead),
            getCellWith(x: 1, y: 0, currentState: .alive),
            getCellWith(x: 1, y: 1, currentState: .permanentlyDead),
            getCellWith(x: 1, y: 2, currentState: .dead),
            getCellWith(x: 2, y: 0, currentState: .dead),
            getCellWith(x: 2, y: 1, currentState: .dead),
            getCellWith(x: 2, y: 2, currentState: .dead)
        ]

        for w in world.cells {
            print(w.currentState)
        }
        XCTAssertEqual(world.cells, resultCells)
    }
}
