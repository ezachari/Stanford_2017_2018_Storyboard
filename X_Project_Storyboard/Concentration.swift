//
//  Concentration.swift
//  X_Project_Storyboard
//
//  Created by Юрий Ни on 05.09.2021.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices where cards[index].isFaced {
                if foundIndex == nil {
                    foundIndex = index
                } else {
                    return nil
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaced = (index == newValue)
            }
        }
    }

    func chooseCard(at index: Int) {
        if !cards[index].isMatch {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                }
                cards[index].isFaced = true
            } else {
                indexOfFaceUpCard = index
            }
        }
    }

    func newGame() {
        for index in cards.indices {
            cards[index].isFaced = false
            cards[index].isMatch = false
        }
        cards.shuffle()
    }

    init(numberOfPairs: Int) {
        for _ in 1...numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
