//
//  ViewController.swift
//  Concentration
//
//  Created by Redemax on 3/1/19.
//  Copyright © 2019 Alisher Altore. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    typealias Theme = (emojies: [String], bgColor: UIColor, cardFrontColor: UIColor, cardBackColor: UIColor)
    
    private var emojiChoices:[String] = []
    private var emoji = [Card:String]()
    
    var theme: Theme = (emojies: ["👻", "🎃", "🧟‍♀️", "👺", "🍭", "🍬", "🦇"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardFrontColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) {
        didSet {
            emojiChoices = theme.emojies
            emoji = [:]
            configureTheme()
            updateViewFromModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTheme()
    }
    
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private var newGameButton: UIButton! {
        didSet {
            newGameButton.layer.cornerRadius = 8.0
            newGameButton.clipsToBounds = true
        }
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choosen card was not in CardButtons")
        }
    }
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.newGame()
        configureTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = theme.cardBackColor
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : theme.cardFrontColor
                }
            }
        }
    }
    
    private func configureTheme() {
        view.backgroundColor = theme.bgColor
        
        newGameButton.setTitleColor(theme.cardBackColor, for: .normal)
        newGameButton.backgroundColor = theme.cardFrontColor
        
        flipCountLabel.textColor = theme.cardFrontColor
        scoreLabel.textColor = theme.cardFrontColor
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
}

