//
//  Cell.swift
//  GameOfLife
//
//  Created by Karen Pinzás Morrongiello on 5/11/18.
//  Copyright © 2018 Karen Pinzás Morrongiello. All rights reserved.
//

import Foundation

enum CellState: String {
    case alive = "😀"
    case dead = "☠️"
    case neverBorn = "🥚"
    case permanentlyDead = "🛑"
}

class Cell {
    let x: Int, y: Int
    var currentState: CellState
    
    init (x: Int, y: Int) {
        self.x = x
        self.y = y
        currentState = .neverBorn
    }
}

extension Cell: Equatable {
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        return (lhs.x == rhs.x && lhs.y == rhs.y) && (lhs.currentState == rhs.currentState)
    }
}
