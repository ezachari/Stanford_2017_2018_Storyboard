//
//  ViewController.swift
//  X_Project_Storyboard
//
//  Created by Юрий Ни on 05.09.2021.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game =
        Concentration(numberOfPairs: numberOfPairs)
    private var numberOfPairs: Int {
        return (cardButtonsCollection.count + 1) / 2
    }
    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "FLIPS: \(flipCount)"
        }
    }
    @IBOutlet weak var newGameButton: UIButton!
    @IBAction func startNewGame(_ sender: UIButton) {
        emojiChoices = ["👻", "🎃", "🧟‍♀️", "👹", "💀", "👿", "🦇", "🧛🏻‍♀️"]
        emoji = [Int: String]()
        flipCount = 0
        game.newGame()
        updateViewFromModel()
    }
    private var emojiChoices = ["👻", "🎃", "🧟‍♀️", "👹", "💀", "👿", "🦇", "🧛🏻‍♀️"]
    private var emoji = [Int: String]()
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtonsCollection: [UIButton]!
    @IBAction private func chooseCard(_ sender: UIButton) {
        if let cardNumber = cardButtonsCollection.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            if game.cards[cardNumber].isFaced {
                flipCount += 1
            }
            updateViewFromModel()
        }
    }
    private func updateViewFromModel() {
        for index in cardButtonsCollection.indices {
            let button = cardButtonsCollection[index]
            let card = game.cards[index]
            if card.isFaced {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
    }

    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count != 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
}
