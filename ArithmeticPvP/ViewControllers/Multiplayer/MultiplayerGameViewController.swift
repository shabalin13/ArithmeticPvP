//
//  MultiplayerGameViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 26.04.2022.
//

import UIKit

class MultiplayerGameViewController: UIViewController {
    
    @IBOutlet var guest2QuestionLabel: UILabel!
    @IBOutlet var guest2AnswerLabel: UILabel!
    @IBOutlet var guest2AnswerLabel1: UIButton!
    @IBOutlet var guest2AnswerLabel2: UIButton!
    @IBOutlet var guest2AnswerLabel3: UIButton!
    @IBOutlet var guest2AnswerLabel4: UIButton!
    @IBOutlet var guest2ProgressView: UIProgressView!
    @IBOutlet var guest2Label: UILabel!
    
    @IBOutlet var guest1QuestionLabel: UILabel!
    @IBOutlet var guest1AnswerLabel: UILabel!
    @IBOutlet var guest1AnswerLabel1: UIButton!
    @IBOutlet var guest1AnswerLabel2: UIButton!
    @IBOutlet var guest1AnswerLabel3: UIButton!
    @IBOutlet var guest1AnswerLabel4: UIButton!
    @IBOutlet var guest1ProgressView: UIProgressView!
    @IBOutlet var guest1Label: UILabel!
    
    var game: MultiplayerGame!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guest2QuestionLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        guest2AnswerLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        guest2AnswerLabel1.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        guest2AnswerLabel2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        guest2AnswerLabel3.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        guest2AnswerLabel4.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        guest2ProgressView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        guest1Label.text = "Player #1"
        guest2Label.text = "Player #2"
        guest2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func startNewGame() {
        game.getTasks()
        guest1ProgressView.setProgress(0, animated: false)
        guest2ProgressView.setProgress(0, animated: false)
                
        newGuest1Round()
        game.guest1.startTime = Date()
        newGuest2Round()
        game.guest2.startTime = Date()
    }
    
    func newGuest1Round() {
        let isAnyTask = game.getGuest1NewTask()
        if isAnyTask {
//            print(game.guest1.currentTask.answer)
            guest1QuestionLabel.text = game.guest1.currentTask.question
            updateGuest1UI()
        } else {
            updateGuest1UI()
            guest1EndGame()
        }
    }
    
    func newGuest2Round() {
        let isAnyTask = game.getGuest2NewTask()
        if isAnyTask {
//            print(game.guest2.currentTask.answer)
            guest2QuestionLabel.text = game.guest2.currentTask.question
            updateGuest2UI()
        } else {
            updateGuest2UI()
            guest2EndGame()
        }
    }
    
    func guest1EndGame() {
        game.guest1.endTime = Date()
        enableGuest1Buttons(false)
        if let _ = game.guest2.endTime {
            performSegue(withIdentifier: "ShowMultiplayerStatistics", sender: nil)
        }
    }
    
    func guest2EndGame() {
        game.guest2.endTime = Date()
        enableGuest2Buttons(false)
        if let _ = game.guest1.endTime {
            performSegue(withIdentifier: "ShowMultiplayerStatistics", sender: nil)
        }
    }
    
    func updateGuest1UI() {
        var answersForTest = game.getGuest1AnswersForTest()
        
        guest1AnswerLabel1.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        guest1AnswerLabel2.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        guest1AnswerLabel3.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        guest1AnswerLabel4.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        
        guest1AnswerLabel.text = "?"
        
        let guest1Progress = Float(game.guest1.numberOfSolvedTasksInGame) / Float(game.guest1.tasks.count)
        guest1ProgressView.setProgress(guest1Progress, animated: true)
    }
    
    func updateGuest2UI() {
        var answersForTest = game.getGuest2AnswersForTest()
        
        guest2AnswerLabel1.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        guest2AnswerLabel2.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        guest2AnswerLabel3.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        guest2AnswerLabel4.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35.0)]), for: .normal)
        
        guest2AnswerLabel.text = "?"
        
        let guest2Progress = Float(game.guest2.numberOfSolvedTasksInGame) / Float(game.guest2.tasks.count)
        guest2ProgressView.setProgress(guest2Progress, animated: true)
    }
    
    @IBAction func guest1TestButtonPressed(_ sender: UIButton) {
        let titleOfButtonPressed = sender.configuration!.title!
        game.guest1testButtonPressed(testButton: titleOfButtonPressed)
        game.guest1.numberOfSolvedTasksInGame += 1
        if game.guest1.currentTask.stringAnswer == game.guest1.currentTask.answer {
            game.guest1.numberOfCorrectTasksInGame += 1
        }
        newGuest1Round()
    }
    
    @IBAction func guest2TestButtonPressed(_ sender: UIButton) {
        let titleOfButtonPressed = sender.configuration!.title!
        game.guest2testButtonPressed(testButton: titleOfButtonPressed)
        game.guest2.numberOfSolvedTasksInGame += 1
        if game.guest2.currentTask.stringAnswer == game.guest2.currentTask.answer {
            game.guest2.numberOfCorrectTasksInGame += 1
        }
        newGuest2Round()
    }
    
    func enableGuest1Buttons(_ enable: Bool) {
        guest1AnswerLabel1.isEnabled = enable
        guest1AnswerLabel2.isEnabled = enable
        guest1AnswerLabel3.isEnabled = enable
        guest1AnswerLabel4.isEnabled = enable
    }
    
    func enableGuest2Buttons(_ enable: Bool) {
        guest2AnswerLabel1.isEnabled = enable
        guest2AnswerLabel2.isEnabled = enable
        guest2AnswerLabel3.isEnabled = enable
        guest2AnswerLabel4.isEnabled = enable
    }
    
    
    @IBSegueAction func showMultiplayerStatistics(_ coder: NSCoder, sender: Any?) -> MultiplayerStatisticsTableViewController? {
        return MultiplayerStatisticsTableViewController(coder: coder, playedGame: game)
    }
    
}
