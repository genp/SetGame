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
        print("deal more cards")
        // TODO
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
            button.titleLabel?.text = ""
            button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    private func updateViewFromModel() {
        
        clearButtons()
        
        for index in 0..<game.displayedCards.count {
            print("\(index) : \(game.displayedCards[index].description)")
            cardButtons[index].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            //cardButtons[index].titleLabel?.text = game.displayedCards[index].description
            stringify(card: game.displayedCards[index], for: cardButtons[index])
            print("card \(index) \(game.displayedCards[index].description)")

        }
        
        scoreCount = game.currentScore
    
    }
    
    private func stringify(card: Card, for button: UIButton) {
        // TODO

        var shape = ""
        var cardShapeWithNumber = ""
        var shading = 1.0
        var color: UIColor? = nil
        
        switch card.shape {
            case Card.Attribute.one: shape = "t"
            case Card.Attribute.two: shape = "c"
            case Card.Attribute.three: shape = "s"
        }
        
        switch card.number {
            case Card.Attribute.one: cardShapeWithNumber = shape
            case Card.Attribute.two: cardShapeWithNumber = String(repeating: shape, count: 2)
            case Card.Attribute.three: cardShapeWithNumber = String(repeating: shape, count: 3)
        }
        
        
        switch card.shading {
        case Card.Attribute.one: shading = 10.0
        case Card.Attribute.two: shading = 20.0
        case Card.Attribute.three: shading = -1.0
        }
        
        switch card.shading {
        case Card.Attribute.one: color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case Card.Attribute.two: color = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        case Card.Attribute.three: color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        
        let font = UIFont.systemFont(ofSize: 15)
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: shading,
            .font: font,
            .strokeColor: color
            
        ]
        let attributedString = NSAttributedString(string: cardShapeWithNumber, attributes: attributes)
        button.setAttributedTitle(attributedString, for: UIControl.State.normal)
        //button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }
    
}
