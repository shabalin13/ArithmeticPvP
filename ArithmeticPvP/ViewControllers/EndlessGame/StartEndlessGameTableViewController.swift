//
//  StartEndlessGameTableViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.04.2022.
//

import UIKit

class StartEndlessGameTableViewController: UITableViewController {
    
    @IBOutlet var gameDifficultySegmentedControl: UISegmentedControl!
    @IBOutlet var answersTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var additionSwitch: UISwitch!
    @IBOutlet var subtractionSwitch: UISwitch!
    @IBOutlet var multiplicationSwitch: UISwitch!
    @IBOutlet var divisionSwitch: UISwitch!
    
    @IBOutlet var timeTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToStartEndlessGame(segue: UIStoryboardSegue) {
    }
    
    @IBAction func SwitchToggled(_ sender: UISwitch) {
        if !additionSwitch.isOn && !subtractionSwitch.isOn && !multiplicationSwitch.isOn && !divisionSwitch.isOn {
            startGameButton.isEnabled = false
        } else {
            startGameButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StartEndlessGame") {
            if let endlessGameVC = segue.destination as? EndlessGameViewController {
                
                var gameDifficulty: GameDifficultyType!
                if gameDifficultySegmentedControl.selectedSegmentIndex == 0 {
                    gameDifficulty = .easy
                } else if gameDifficultySegmentedControl.selectedSegmentIndex == 1 {
                    gameDifficulty = .normal
                } else if gameDifficultySegmentedControl.selectedSegmentIndex == 2 {
                    gameDifficulty = .hard
                } else if gameDifficultySegmentedControl.selectedSegmentIndex == 3 {
                    gameDifficulty = .insane
                }
                
                var operations = [GameOperationsType]()
                if additionSwitch.isOn { operations.append(.addition) }
                if subtractionSwitch.isOn { operations.append(.subtraction) }
                if multiplicationSwitch.isOn { operations.append(.multiplication) }
                if divisionSwitch.isOn { operations.append(.division) }
                
                var answersType: GameAnswersType!
                if answersTypeSegmentedControl.selectedSegmentIndex == 0 {
                    answersType = .test
                } else if answersTypeSegmentedControl.selectedSegmentIndex == 1 {
                    answersType = .random
                } else if answersTypeSegmentedControl.selectedSegmentIndex == 2 {
                    answersType = .keyboard
                }
                
                var timeType: GameTimeType!
                if timeTypeSegmentedControl.selectedSegmentIndex == 0 {
                    timeType = .withTime
                } else if timeTypeSegmentedControl.selectedSegmentIndex == 1 {
                    timeType = .withoutTime
                }
                
                if !operations.isEmpty {
                    endlessGameVC.game = EndlessGame(typeOfDifficulty: gameDifficulty, typeOfAnswers: answersType, typeOfTime: timeType, operations: operations)
                }
            }
        }
    }

}
