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
        // check if already selected cards make a set
        if selectedCards.count == 3 {
            if checkIfMakesSet() {
                displayedCards = displayedCards.filter { !selectedCards.contains($0) }
                deal(numCards: min(cardDeck.cardsLeft, 3))
                currentScore += 5
            } else {
                currentScore -= 3
            }

            selectedCards  = [Card]()
            return
        }
        
        // check if deselecting
        if selectedCards.contains(card){
            selectedCards.remove(at: selectedCards.firstIndex(of: card)!)
            currentScore -= 1
            return
        }

        selectedCards.append(card)
    }
    
    static func isSet(_ c1: Card, _ c2: Card, _ c3: Card) -> Bool {
        for selector in Card.allSelectors {
            let attrs = [c1,c2,c3].map({selector($0)})
            if (!(attrs.allSame || attrs.allDifferent)) {
                return false
            }
        }
        return true
    }

    func checkIfMakesSet() -> Bool {
        if selectedCards.count == 3 {
            return SetGame.isSet(selectedCards[0], selectedCards[1], selectedCards[2])
        }
        return false
    }

    func deal(numCards: Int) {
        assert(numCards <= cardDeck.cardsLeft, "Tried to deal \(numCards) with only \(cardDeck.cardsLeft) left")
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
