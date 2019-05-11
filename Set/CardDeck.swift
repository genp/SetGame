//
// Created on 5/7/19
//
// Using Swift 5.0
//
// Set -- CardDeck.swift :
//

import Foundation

struct CardDeck
{
    private var cards = [Card]()
    
    init() {
        for number in Card.Attribute.allCases {
            for shape in Card.Attribute.allCases {
                for shading in Card.Attribute.allCases {
                    for color in Card.Attribute.allCases {
                        cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
    }
    
    var cardsLeft: Int {
        return cards.count
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        }
        return nil
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
