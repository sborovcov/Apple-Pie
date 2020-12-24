//
//  ViewController.swift
//  Apple Pie
//
//  Created by Stas Borovtsov on 23.12.2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB OutLets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listDrinks = ["Виски", "Кола", "Лимонад", "Сок", "Молоко", "Пиво", "Вода", "Кофе", "Чай"].shuffled() // shuffled() - случайный порядок
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    func newRound(){
        guard !listDrinks.isEmpty else{ //проверка того, что в списке слов кончились слова
            enableButtons(false)
            updateUI()
            return
        }
        
        let newWord = listDrinks.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updatecorrectWordLabel(){
        var displayWord = [String]()
        for letter in currentGame.guessedWord{
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState(){
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        }else if currentGame.guessedWord == currentGame.word{
            totalWins += 1
        }
        updateUI()
    }
    
    func updateUI(){
        let movesRemaining = currentGame.incorrectMovesRemaining
        let treeName = "Tree\(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)"
        treeImageView.image = UIImage(named: treeName)
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
        updatecorrectWordLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    // MARK: - IB Action
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
}

