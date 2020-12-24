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
    var listDrinks = ["Виски", "Кола", "Лимонад", "Сок", "Молоко", "Пиво", "Вода", "Кофе", "Чай"]
    var totalWins = 0
    var totalLosses = 0
    
    // MARK: - Methods
    func newRound(){
        let newWord = listDrinks.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
    }
    
    func updatecorrectWordLabel(){
        var displayWord = [String]()
        for letter in currentGame.guessedWord{
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateUI(){
        let movesRemaining = currentGame.incorrectMovesRemaining
        let treeName = "Tree\(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)"
        treeImageView.image = UIImage(named: treeName)
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
        //correctWordLabel.text = currentGame.guessedWord // вместо этого сделаем функцию с разделителями, хотя можно просто при формировании guessedWord добавлять пробелы при выводе подчеркивания. Но это лучше, так как мы изменяем строку только при выводе на экран
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
        updateUI()
    }
}

