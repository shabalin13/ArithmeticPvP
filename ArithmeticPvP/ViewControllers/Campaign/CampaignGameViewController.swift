//
//  CampaignGameViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2022.
//

import UIKit

class CampaignGameViewController: UIViewController {
    
    var game: CampaignGame!
    var currentTime: Double?
    var totalTime: Double?
    var timer = Timer()
    
    @IBOutlet var timeProgressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var keyboardStackView: UIStackView!
    @IBOutlet var testStackView: UIStackView!
    
    
    @IBOutlet var answerLabel1: UIButton!
    @IBOutlet var answerLabel2: UIButton!
    @IBOutlet var answerLabel3: UIButton!
    @IBOutlet var answerLabel4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        self.title = game.level.name
        
        if game.level.typeOfAnswer == .test {
            testStackView.isHidden = false
            keyboardStackView.isHidden = true
        } else if game.level.typeOfAnswer == .keyboard {
            testStackView.isHidden = true
            keyboardStackView.isHidden = false
        } else if game.level.typeOfAnswer == .random {
            testStackView.isHidden = true
            keyboardStackView.isHidden = true
        }
        
        startCampaignGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    func startCampaignGame() {
        (self.currentTime, self.totalTime) = self.game.setTime()
        timeProgressView.setProgress(1.0, animated: false)
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimeProgress), userInfo: nil, repeats: true)
        
//        if game.level.typeOfTime == .withTime {
//            self.timeProgressView.setProgress(1.0, animated: false)
//            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimeProgress), userInfo: nil, repeats: true)
//        }
        
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
                    self.timer.invalidate()
                    self.game.level.isOnTime = false
                }
            }
        }
    }

    func newRound() {
        let isAnyTask = game.getNewTask()
        if isAnyTask {
            print(game.currentTask.answer)
            if game.currentTask.type == .test {
                testStackView.isHidden = false
                keyboardStackView.isHidden = true
            } else if game.currentTask.type == .keyboard {
                testStackView.isHidden = true
                keyboardStackView.isHidden = false
            }
            questionLabel.text = game.currentTask.question
            updateUI()
        } else {
            endGame()
        }
    }
    
    func endGame() {
        enableButtons(false)
        
        if game.level.isOnTime {
            timer.invalidate()
        }
        performSegue(withIdentifier: "ShowCampaignStatistics", sender: nil)
    }
    
    func enableButtons(_ enable: Bool) {
        for button in buttons {
            button.isEnabled = enable
        }
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
                game.level.numberOfCorrectAnswers += 1
            }
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
            game.level.numberOfCorrectAnswers += 1
        }
        newRound()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIBarButtonItem) {
        if game.level.isOnTime {
            timer.invalidate()
        }
        performSegue(withIdentifier: "ShowCampaignStatistics", sender: nil)
    }
    
    @IBSegueAction func showCampaignStatistics(_ coder: NSCoder, sender: Any?) -> CampaignStatisticsTableViewController? {
        return CampaignStatisticsTableViewController(coder: coder, playedGame: game)
    }

}
