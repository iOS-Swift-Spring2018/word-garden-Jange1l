//
//  ViewController.swift
//  Word Garden
//
//  Created by montserratloan on 2/10/18.
//  Copyright © 2018 Juan Suarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var guessedLetterButton: UIButton!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var howManyGuesses: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var flowerImage: UIImageView!
    var wordToGuess = " "
    var index = 0
    var lettersGuessed = ""
    let maxNumberofWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    let list = ["SWIFT", "CODE", "APPLE", "SUN FLOWER", "BOSTON COLLEGE", "JEBBIT", "TECHTREK", "JUAN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In ViewDidLoad, is guessedLetterField the first responder?",
        guessedLetterField.isFirstResponder)
        guessedLetterButton.isEnabled = false
        playAgain.isHidden = true
        selectWord()
        
    }
    func selectWord() {
        wordToGuess = list[index]
        index += 1
        if index == list.count - 1 {
            index = 0
        }
    }
    

    func changeUIinput() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    func formatMessage() {
        var revealedWord = " "
        lettersGuessed += guessedLetterField.text!
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
                
            }else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    func guessALetter() {
        formatMessage()
        guessCount += 1
        // decrements the wrong guessesRemaining and shows the next flower image
        //with one less pedal
        let currentLetterGuesed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuesed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImage.image = UIImage(named: "flower\(wrongGuessesRemaining)")
            
        }
        
        let revealedWord = userGuessLabel.text!
        // Stop game if wrongGuessesRemaining = 0
    if wrongGuessesRemaining == 0 {
        playAgain.isHidden = false
        guessedLetterField.isEnabled = false
        guessedLetterButton.isEnabled = false
        howManyGuesses.text = "So sorry, you're all out of guesses. Try again?"
    } else if !revealedWord.contains("_") {
        //you've won a game!
        playAgain.isHidden = false
        guessedLetterField.isEnabled = false
        guessedLetterButton.isEnabled = false
        howManyGuesses.text = "You've got it! Took you \(guessCount) Guesses to guess the word!"
    }else{
        //update game count
        let guess = (guessCount == 1 ? "Guess" : "Guesses" )
//        var guess = "guesses"
//        if guessCount == 1 {
//            guess = "guess"
//        }
        
        howManyGuesses.text = "You've made \(guessCount) \(guess)"
        }
    }
    
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let lettersGuessed = guessedLetterField.text?.last {
            guessedLetterField.text =  "\(lettersGuessed)"
            guessedLetterButton.isEnabled = true
        }else {
            // disable the button if i don't have a single character in the guessedLetterField
            guessedLetterButton.isEnabled = false
            
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        
        guessALetter()
        changeUIinput()

        
    }
    
    
    @IBAction func guessedLetterButton(_ sender: UIButton) {
        guessALetter()
        changeUIinput()
    }
    
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        selectWord()
        playAgain.isHidden = true
        guessedLetterField.isEnabled = true
        guessedLetterButton.isEnabled = false
        flowerImage.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberofWrongGuesses
        lettersGuessed = ""
        formatMessage()
        howManyGuesses.text = "You've made 0 Guesses"
        guessCount = 0
        
    }
    
    
}

