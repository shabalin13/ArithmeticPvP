//
//  GameViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 04.04.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    
//    @IBOutlet var keyboardButtons: [UIButton]!
//    @IBOutlet var answerLabel: UILabel!
//    @IBOutlet var questionLabel: UILabel!
//    @IBOutlet var usernameLabel: UILabel!
//    @IBOutlet var progressView: UIProgressView!
//    
//    
//    var game: Game!
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        startNewGame()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    
//    
//    func startNewGame() {
////
//        
//        if let savedPlayer = Player.loadPlayer() {
//            game = Game(endTime: nil, player: savedPlayer)
//        } else {
//            game = Game(endTime: nil, player: Player(username: "DIMbI4"))
//        }
//        
//        usernameLabel.text = game.player.username
//        
//        newRound()
//    }
//    
//    func newRound() {
//        let response = game.isThereTask()
//        if response.isOK {
//            game.player.currentTask = response.task
//            questionLabel.text = game.player.currentTask!.question
//            updateUI()
//        } else {
//            endGame()
//        }
//    }
//    
//    func endGame() {
//        game.endTime = Date()
//        enableKeyboardButtons(false)
//        calculateAvgSpeed()
//        calculateNumberOfSolvedTasks()
//        calculateNumberOfPlayedGames()
//        game.player.currentTask = nil
//        game.player.numberOfSolvedTasksInGame = 0
//        Player.savePlayer(game.player)
//        performSegue(withIdentifier: "Statistics", sender: nil)
//    }
//    
//    func calculateAvgSpeed() {
//        let averageSpeed = game.endTime!.timeIntervalSince(game.startTime) / Double(game.numberOfTasks)
//        let dateComponentsFormatter = DateComponentsFormatter()
//        dateComponentsFormatter.allowedUnits = [.hour, .minute, .second]
//        dateComponentsFormatter.unitsStyle = .full
//        game.player.avgSpeed = "1 task per " + dateComponentsFormatter.string(from: averageSpeed)!
//    }
//    
//    func calculateNumberOfSolvedTasks() {
//        game.player.totalNumberOfTasksSolved += game.numberOfTasks
//    }
//    
//    func calculateNumberOfPlayedGames() {
//        game.player.numberOfPlayedGames += 1
//    }
//    
//
//    @IBSegueAction func showStatistics(_ coder: NSCoder) -> StatisticsTableViewController? {
//        Player.savePlayer(game.player)
//        return StatisticsTableViewController(coder: coder, playedGame: game)
//    }
//    
//    func enableKeyboardButtons(_ enable: Bool) {
//        for button in keyboardButtons {
//            button.isEnabled = enable
//        }
//    }
//    
//    func updateUI() {
//        answerLabel.text = game.player.currentTask!.formattedCurentAnswer
//        let playerProgress = Float(game.player.numberOfSolvedTasksInGame) / Float(game.numberOfTasks)
//        progressView.setProgress(playerProgress, animated: true)
//    }
//    
//    
//    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
//        let titleOfButtonPressed = sender.configuration!.title!
//        game.player.playerEnter(keybordButton: titleOfButtonPressed)
//        checkGameState()
//    }
//    
//    func checkGameState() {
////        if String(game.player.currentTask!.currentAnswer) == game.player.currentTask!.answer {
//        if game.player.currentTask!.currentAnswer.joined(separator: "") == game.player.currentTask!.answer {
//            game.player.numberOfSolvedTasksInGame += 1
//            updateUI()
//            newRound()
//        } else {
//            updateUI()
//        }
//    }

}
