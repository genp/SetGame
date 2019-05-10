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
        print("a card got touched")
        let cardIndex = cardButtons.firstIndex(of: sender)!
        game.select(card: game.displayedCards[cardIndex])
        updateViewFromModel()
        
    }
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        if game.displayedCards.count >= 24 {
            print("Card table full")
            return
        }
        for _ in 1...3 {
            game.drawCard()
        }
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
            button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha:0.0)
            button.layer.borderWidth = 0.0

        }
    }
    
    private func updateViewFromModel() {
        
        clearButtons()
        
        if game.displayedCards.count < 12 {
            for _ in game.displayedCards.count..<12 {
                game.drawCard()
            }
        }
        
        
        for index in 0..<game.displayedCards.count {
            cardButtons[index].isEnabled = true
            print("\(index) : \(game.displayedCards[index].description)")
            cardButtons[index].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            //cardButtons[index].titleLabel?.text = game.displayedCards[index].description
            stringify(card: game.displayedCards[index], for: cardButtons[index])
            print("card \(index) \(game.displayedCards[index].description)")
            
            if game.selectedCards.contains(game.displayedCards[index]) {
                cardButtons[index].layer.borderWidth = 3.0
                cardButtons[index].layer.borderColor = UIColor.blue.cgColor
            } else {
                cardButtons[index].layer.borderWidth = 0.0
            }
        }
        if game.displayedCards.count >= 24 {
            dealButton.isEnabled = false
        }
        scoreCount = game.currentScore
    
    }
    
    private func stringify(card: Card, for button: UIButton) {
        // TODO

        var shape = ""
        var cardShapeWithNumber = ""
        var shading = 1.0
        var color: UIColor
        
        switch card.shape {
            case Card.Attribute.one: shape = "▲"
            case Card.Attribute.two: shape = "⚪︎"
            case Card.Attribute.three: shape = "□"
        }
        
        switch card.number {
            case Card.Attribute.one: cardShapeWithNumber = shape
            case Card.Attribute.two: cardShapeWithNumber = String(repeating: shape, count: 2)
            case Card.Attribute.three: cardShapeWithNumber = String(repeating: shape, count: 3)
        }
        
        
        switch card.shading {
            case Card.Attribute.one: shading = 0.0
            case Card.Attribute.two: shading = 0.15
            case Card.Attribute.three: shading = 1.0
        }
        
        switch card.color {
        case Card.Attribute.one: color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: CGFloat(shading))
        case Card.Attribute.two: color = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: CGFloat(shading))
        case Card.Attribute.three: color = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: CGFloat(shading))
        }
        
        let font = UIFont.systemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .strokeColor: color
            
        ]
        let attributedString = NSAttributedString(string: cardShapeWithNumber, attributes: attributes)
        button.setAttributedTitle(attributedString, for: UIControl.State.normal)
        //button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }
    
}
