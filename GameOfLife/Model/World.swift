//
//  World.swift
//  GameOfLife
//
//  Created by Karen Pinzás Morrongiello on 5/11/18.
//  Copyright © 2018 Karen Pinzás Morrongiello. All rights reserved.
//

import Foundation

class World {
    var cells: [Cell] = []
    let dimension: Int
    
    init(withDimension dimension: Int) {
        self.dimension = dimension
        createCells()
    }
    
    fileprivate func createCells() {
        for x in 0..<self.dimension {
            for y in 0..<self.dimension {
                cells.append(Cell(x: x, y: y))
            }
        }
    }
    
    func getCellWith(x: Int, y: Int) -> Cell? {
        return cells.filter { $0.x == x && $0.y == y }.first
    }

    func checkCellsStates() {
        let liveCells = cells.filter { $0.currentState == .alive }
        let canLiveCells = cells.filter { $0.currentState != .alive && $0.currentState != .permanentlyDead } // neverBorn, dead
        let deadCells = canLiveCells.filter { $0.currentState == .dead }
        
        // a living cell with 1 or less neighbors dies
        // a living cell with 4 or more neighbors dies
        // a living cell with 2 or 3 neighbors continues living
        let dyingCells = liveCells.filter {
            let value = getNumberOfLivingCellsNear(cell: $0)
            switch value {
            case 2...3:
                return false
            default:
                return true
            }
        }
        
        // a dead cell with 3 neighbors starts to live
        let newLiveCells = canLiveCells.filter {
            let value = getNumberOfLivingCellsNear(cell: $0)
            if value == 3 {
                return true
            } else {
                return false
            }
        }
        
        // a dead cell with 4 or more neighbors becomes permanently dead
        let permanentlyDeadCells = deadCells.filter { getNumberOfLivingCellsNear(cell: $0) > 3 }
        
        dyingCells.forEach { (cell: Cell) in cell.currentState = .dead }
        newLiveCells.forEach { (cell: Cell) in cell.currentState = .alive }
        permanentlyDeadCells.forEach { (cell: Cell) in cell.currentState = .permanentlyDead }
    }
    
    func getNeighboursFor(_ cell: Cell) -> [Cell] {
        return cells.filter { areNeighbours(cell1: cell, cell2: $0)}
    }
    
    func areNeighbours(cell1: Cell, cell2: Cell) -> Bool {
        let delta = (abs(cell1.x - cell2.x), abs(cell1.y - cell2.y))
        switch (delta) {
        case (1,1), (1,0), (0,1):
            return true
        default:
            return false
        }
    }
    
    func getNumberOfLivingCellsNear(cell: Cell) -> Int {
        let neighboursForCell = getNeighboursFor(cell)
        return neighboursForCell.filter { $0.currentState == CellState.alive }.count
    }
}
