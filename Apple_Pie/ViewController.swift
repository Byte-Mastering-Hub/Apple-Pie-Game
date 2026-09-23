//
//  ViewController.swift
//  Apple_Pie
//
//  Created by Sumit Tak on 10/09/25.
//

import UIKit

var listOfWords = [
    "apple", "banana", "orange", "grape", "mango",
    "peach", "pear", "papaya", "kiwi", "cherry",

    // Common fruits
    "pineapple", "strawberry", "watermelon", "melon", "lemon",
    "lime", "plum", "apricot", "pomegranate", "guava",

    // Tropical fruits
    "coconut", "lychee", "dragonfruit", "passionfruit", "jackfruit",
    "durian", "fig", "date", "sapota", "custardapple",

    // Berries
    "blueberry", "raspberry", "blackberry", "cranberry", "mulberry",

    // Citrus & others
    "tangerine", "clementine", "mandarin", "pomelo", "grapefruit",

    // Indian & regional fruits
    "jamun", "amla", "bael", "karonda", "phalsa",

    // Fun & slightly tricky
    "avocado", "olive", "persimmon", "starfruit", "breadfruit"
]

let incorrectMovesAllowed = 7

var totalWins = 0
var totalLosses = 0


class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLablel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }

    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
        
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLablel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            newRound()
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
}

