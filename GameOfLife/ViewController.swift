//
//  ViewController.swift
//  GameOfLife
//
//  Created by Karen Pinzás Morrongiello on 5/11/18.
//  Copyright © 2018 Karen Pinzás Morrongiello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var board: UITextView!
    @IBOutlet fileprivate weak var cellGenerationLabel: UILabel!
    fileprivate var world: World?
    var isGameRunning = false
    var currentTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGenerations(with: 0)
        showWorld()
    }
    
    func createGame() {
        world = World(withDimension: 20)
        selectRandomLocations()
        showWorld()
        updateGenerations(with: 1)
    }
    
    func selectRandomLocations() {
        for _ in 0...200 {
            let randomX = Int(arc4random()) % (world?.dimension)!
            let randomY = Int(arc4random()) % (world?.dimension)!
            print("x:\(randomX), y:\(randomY)")
            world?.getCellWith(x: randomX, y: randomY)?.currentState = .alive
        }
    }
    
    func startGame() {
        showWorld()
        var generations = 1
        currentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            generations += 1
            self.updateGenerations(with: generations)
            self.world?.checkCellsStates()
            self.showWorld()
        }
        currentTimer.fire()
    }
    
    func showWorld() {
        var boardString = ""
        var _ = world?.cells.map ({
            if ($0.y + 1) == world?.dimension {
                boardString = boardString + ("\($0.currentState.rawValue)\n")
            } else {
                boardString = boardString + $0.currentState.rawValue
            }
        })
        board.text = boardString
    }

    @IBAction func createGame(_ sender: UIButton) {
        currentTimer.invalidate()
        createGame()
        startGame()
    }

    @IBAction func startGame(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        createGame()
        startGame()
    }
    
    func updateGenerations(with numberOfGenerations: Int) {
        cellGenerationLabel.text = "Generation Number \(numberOfGenerations)"
    }
}

