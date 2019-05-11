//
// Created on 5/7/19
//
// Using Swift 5.0
//
// Set -- SetGame.swift :
//

import Foundation

class SetGame
{
    private(set) var cardDeck = CardDeck()
    
    private(set) var currentScore = 0
    
    private(set) var selectedCards = [Card]()
    private(set) var displayedCards = [Card]()
    
    func select(card: Card) {
        // check if deselecting
        if selectedCards.contains(card){
            selectedCards.remove(at: selectedCards.firstIndex(of: card)!)
            currentScore -= 1
            return
        }
        
        // check if already selected cards make a set
        if selectedCards.count == 3 {
            if checkIfMakesSet() {
                displayedCards = displayedCards.filter { !selectedCards.contains($0) }
                currentScore += 5
            } else {
                currentScore -= 3
            }
            selectedCards  = [Card]()
        }
        selectedCards.append(card)
        
    }
    
    func checkIfMakesSet() -> Bool{
        if selectedCards.count == 3 {
            for selector: (Card)->Card.Attribute in Card.allSelectors {
                let attrs = selectedCards.map({selector($0)})
                if (!(attrs.allSame || attrs.allDifferent)) {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func deal(numCards: Int) {
        assert(numCards < cardDeck.cardsLeft, "Tried to deal \(numCards) with only \(cardDeck.cardsLeft) left")
        for _ in 1...numCards {
            displayedCards.append(cardDeck.draw()!)
        }
    }

    init(numberOfCardsToStart: Int) {
        deal(numCards: numberOfCardsToStart)
    }
}

extension Array where Element: Hashable {
    var allSame: Bool {
        return self.isEmpty || Set(self).count == 1
    }
    
    var allDifferent: Bool {
        return Set(self).count == self.count
    }
}
