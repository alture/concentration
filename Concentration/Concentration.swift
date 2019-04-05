//
//  Concentration.swift
//  Concentration
//
//  Created by Redemax on 3/2/19.
//  Copyright © 2019 Alisher Altore. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnlyOne
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }
        }
    }
    private(set) var score = 0
    private(set) var flipCount = 0
    private var seenCards: Set<Int> = []
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if seenCards.contains(index) {
                        score -= 1
                    }
                    if seenCards.contains(matchIndex) {
                        score -= 1
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func newGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        
        seenCards.removeAll()
        cards.shuffle()
        flipCount = 0
        score = 0
        indexOfOneAndOnlyFaceUpCard = nil
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnlyOne: Element? {
        return count == 1 ? first : nil
    }
}
