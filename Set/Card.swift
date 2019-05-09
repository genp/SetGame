//
// Created on 5/7/19
//
// Using Swift 5.0
//
// Set -- Card.swift :
//

import Foundation

struct Card: Hashable, Equatable, CustomStringConvertible
{
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
//    var isFaceUp = false
//    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(number: Attribute, shape: Attribute, shading: Attribute, color: Attribute){
        self.number = number
        self.shape = shape
        self.shading = shading
        self.color = color
        self.identifier = Card.getUniqueIdentifier()
    }
    
    var number: Attribute
    var shape: Attribute
    var shading: Attribute
    var color: Attribute
    
    enum Attribute: String, CaseIterable {
        case one
        case two
        case three
    
    }
    
    static var allSelectors: [(Card)->Card.Attribute] {
        return [{$0.number}, {$0.shape}, {$0.shading}, {$0.color}]
    }

    var description: String {
        return "Card: \(number) \(shape) \(shading) \(color)"
    }

    
}
