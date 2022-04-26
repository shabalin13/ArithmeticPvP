//
//  StartMultiplayerGameTableViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 26.04.2022.
//

import UIKit

class StartMultiplayerGameTableViewController: UITableViewController {

    @IBOutlet var gameDifficultySegmentedControl: UISegmentedControl!
    
    @IBOutlet var additionSwitch: UISwitch!
    @IBOutlet var subtractionSwitch: UISwitch!
    @IBOutlet var multiplicationSwitch: UISwitch!
    @IBOutlet var divisionSwitch: UISwitch!
    
    @IBOutlet var startGameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    @IBAction func unwindToStartMultiplayerGame(segue: UIStoryboardSegue) {
    }
    
    @IBAction func SwitchToggled(_ sender: UISwitch) {
        if !additionSwitch.isOn && !subtractionSwitch.isOn && !multiplicationSwitch.isOn && !divisionSwitch.isOn {
            startGameButton.isEnabled = false
        } else {
            startGameButton.isEnabled = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StartMultiplayerGame") {
            if let MultiplayerGameVC = segue.destination as? MultiplayerGameViewController {
                
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
                
                var guests = [Guest]()
                for id in 0..<2 {
                    guests.append(Guest(username: "Guest #\(id + 1)"))
                }
                
                if !operations.isEmpty {
                    MultiplayerGameVC.game = MultiplayerGame(typeOfDifficulty: gameDifficulty, operations: operations, guest1: guests[0], guest2: guests[1])
                }
            }
        }
    }

}
