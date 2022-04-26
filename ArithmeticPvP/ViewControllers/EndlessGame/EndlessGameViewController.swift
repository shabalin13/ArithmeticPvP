//
//  EndlessGameViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.04.2022.
//

import UIKit

class EndlessGameViewController: UIViewController {
    
    @IBOutlet var timeProgressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var keyboardButtons: [UIButton]!
    
    @IBOutlet var keyboardStackView: UIStackView!
    @IBOutlet var testStackView: UIStackView!
    
    @IBOutlet var answerLabel1: UIButton!
    @IBOutlet var answerLabel2: UIButton!
    @IBOutlet var answerLabel3: UIButton!
    @IBOutlet var answerLabel4: UIButton!
    
    
    var game: EndlessGame!
    var currentTime: Double?
    var totalTime: Double?
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        if game.typeOfTime == .withoutTime {
            timeProgressView.isHidden = true
        } else if game.typeOfTime == .withTime {
            timeProgressView.isHidden = false
        }
        
        if game.typeOfAnswers == .test {
            testStackView.isHidden = false
            keyboardStackView.isHidden = true
        } else if game.typeOfAnswers == .keyboard {
            testStackView.isHidden = true
            keyboardStackView.isHidden = false
        } else if game.typeOfAnswers == .random {
            testStackView.isHidden = true
            keyboardStackView.isHidden = true
        }

        startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    func startNewGame() {
        
        setTime()
        
        if game.typeOfTime == .withTime {
            self.timeProgressView.setProgress(1.0, animated: false)
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimeProgress), userInfo: nil, repeats: true)
        }
        
        newRound()
        
    }
    
    @objc func updateTimeProgress() {
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.currentTime = self.currentTime! - 0.1
            DispatchQueue.main.async {
                self.timeProgressView.setProgress(Float(self.currentTime! / self.totalTime!), animated: true)
            }
            
            if self.currentTime! <= 0 {
                DispatchQueue.main.async {
                    self.setTime()
                    self.newRound()
                }

            }
        }
    }
    
    func setTime() {
        if game.typeOfTime == .withoutTime {
            currentTime = nil
            totalTime = nil
        } else if game.typeOfTime == .withTime {
            if game.typeOfDifficulty == .easy {
                currentTime = 5
                totalTime = 5
            } else if game.typeOfDifficulty == .normal {
                currentTime = 12
                totalTime = 12
            } else if game.typeOfDifficulty == .hard {
                currentTime = 20
                totalTime = 20
            } else if game.typeOfDifficulty == .insane {
                currentTime = 30
                totalTime = 30
            }
            timeProgressView.setProgress(1.0, animated: false)
        }
    }
    
    func newRound() {
        game.getNewTask()
        if game.currentTask.type == .test {
            testStackView.isHidden = false
            keyboardStackView.isHidden = true
        } else if game.currentTask.type == .keyboard {
            testStackView.isHidden = true
            keyboardStackView.isHidden = false
        }
        questionLabel.text = game.currentTask.question
        print(game.currentTask.answer)
        updateUI()
    }
    
    func updateUI() {
        if game.currentTask.type == .test {
            var answersForTest = game.getAnswersForTest()
            
            answerLabel1.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40.0)]), for: .normal)
            
            answerLabel2.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40.0)]), for: .normal)
            
            answerLabel3.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40.0)]), for: .normal)
            
            answerLabel4.setAttributedTitle(NSAttributedString(string: answersForTest.removeFirst(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40.0)]), for: .normal)
            
            answerLabel.text = "?"
            
        } else if game.currentTask.type == .keyboard {
            answerLabel.text = game.currentTask.formattedCurentAnswer
        }
    }
    
    
    func checkGameState() {
        if !game.currentTask.currentAnswer.contains("_") {
            updateUI()
            if game.currentTask.stringAnswer == game.currentTask.answer {
                game.numberOfCorrectAnswers += 1
            }
            self.timeProgressView.setProgress(1.0, animated: false)
            setTime()
            newRound()
        } else {
            updateUI()
        }
    }
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        let titleOfButtonPressed = sender.configuration!.title!
        game.keyboardButtonPressed(keybordButton: titleOfButtonPressed)
        checkGameState()
    }
    
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        let titleOfButtonPressed = sender.configuration!.title!
        game.testButtonPressed(testButton: titleOfButtonPressed)
        if game.currentTask.stringAnswer == game.currentTask.answer {
            game.numberOfCorrectAnswers += 1
        }
        self.timeProgressView.setProgress(1.0, animated: false)
        setTime()
        newRound()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIBarButtonItem) {
        timer.invalidate()
        performSegue(withIdentifier: "ShowEndlessStatistics", sender: nil)
    }
    
    
    @IBSegueAction func showStatistics(_ coder: NSCoder, sender: Any?) -> EndlessStatisticsTableViewController? {
        return EndlessStatisticsTableViewController(coder: coder, playedGame: game)
    }

}
