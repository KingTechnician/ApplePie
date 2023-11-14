//
//  ViewController.swift
//  ApplePieMobile
//
//  Created by Isaiah Freeman  on 11/14/23.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["tree","huge","kite"]
    var incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter:letter)
        updateGameState()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    var currentGame: Game!
    func updateGameState()
    {
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses+=1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins+=1
        }
        else
        {
            updateUI()
        }
    }
    func updateUI()
    {
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator:" ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named:"Tree \(currentGame.incorrectMovesRemaining)")
    }
    func enableLetterButtons(_ enable: Bool)
    {
        for button in letterButtons{
            button.isEnabled=enable
        }
    }
    func newRound()
    {
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word:newWord,incorrectMovesRemaining:incorrectMovesAllowed,guessedLetters:[])
            updateUI()
            enableLetterButtons(true)
        }
        else
        {
            enableLetterButtons(false)
        }
    }


}

