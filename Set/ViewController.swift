//
//  ViewController.swift
//  Set
//
//  Created by Genevieve Patterson on 5/6/19.
//  Copyright © 2019 Genevieve Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for button in cardButtons {
            button.layer.cornerRadius = 8.0
        }
        dealButton.setTitleColor(UIColor.gray, for: .disabled)
        updateViewFromModel() 
    }

    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
 
    @IBOutlet weak var dealButton: UIButton!
    
    private lazy var game = SetGame(numberOfCardsToStart: 12)
    

    private(set) var scoreCount = 0 {
        didSet {
            scoreLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let index = cardButtons.firstIndex(of: sender)!
        let card = game.displayedCards[index]
        print("card \(card) touched")
        game.select(card: card)
        updateViewFromModel()
        
    }
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        print("deal more cards")
        game.deal(numCards: 3)
        updateViewFromModel()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        print("start new game!")
        
        // make a new game
        game = SetGame(numberOfCardsToStart: 12)
    
        // update view to show new game
        updateViewFromModel()
        
        // reset scoreCount
        scoreCount = 0
        
    }
    
    private func clearButtons() {
        for button in cardButtons {
            button.isEnabled = false
            button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
            button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha:0.2)
            button.layer.borderWidth = 0.0
        }
    }
    
    private func updateViewFromModel() {
        clearButtons()
        
        for index in 0..<game.displayedCards.count {
            let button = cardButtons[index]
            button.isEnabled = true
            button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            let card = game.displayedCards[index]
            stringify(card: card, for: button)
            
            if game.selectedCards.contains(card) {
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.blue.cgColor
            } else {
                button.layer.borderWidth = 0.0
            }
        }

        scoreCount = game.currentScore
    
        if (game.displayedCards.count + 3 <= cardButtons.count) {
            dealButton.isEnabled = true
        } else {
            dealButton.isEnabled = false
        }
    }
    
    private func stringify(card: Card, for button: UIButton) {
        var shape = "";
        switch card.shape {
            case .one: shape = "▲"
            case .two: shape = "●"
            case .three: shape = "■"
        }
        
        var cardShapeWithNumber = ""
        switch card.number {
            case .one: cardShapeWithNumber = shape
            case .two: cardShapeWithNumber = String(repeating: shape, count: 2)
            case .three: cardShapeWithNumber = String(repeating: shape, count: 3)
        }
        
        var alpha : CGFloat = 1.0
        var stroke : CGFloat = -1.0
        switch card.shading {
            case .one: /* fill */
                /* defaults */
                break
            case .two: /* stripe */
                alpha = 0.15
            case .three: /* outline */
                stroke = 6.0
        }
        
        var fgColor: UIColor
        switch card.color {
        case .one:
            fgColor = UIColor.red
        case .two:
            fgColor = UIColor.green
        case .three:
            fgColor = UIColor.blue
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: fgColor.withAlphaComponent(alpha),
            .strokeWidth: stroke
        ]
        let attributedString = NSAttributedString(string: cardShapeWithNumber, attributes: attributes)
        button.setAttributedTitle(attributedString, for: UIControl.State.normal)
    }
    
}
