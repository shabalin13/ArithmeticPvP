//
//  ProfileViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 20.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var numberOfStarsLabel: UILabel!
    @IBOutlet var additionStatLabel: UILabel!
    @IBOutlet var subtractionStstLabel: UILabel!
    @IBOutlet var multiplicationStatLabel: UILabel!
    @IBOutlet var divisionStatLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = Player.loadPlayer() {
            print("Player exists")
            updateUI()
        } else {
            
            print("Player does not exist")
            
            let alert = UIAlertController(title: "Create User", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in textField.placeholder = "Username"}
            
            alert.addAction(UIAlertAction(title: "CREATE", style: .default, handler: { (_) in
                let textField = alert.textFields![0]
                if textField.text == "" {
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let player = Player(username: textField.text!)
                    print("Player created")
                    Player.savePlayer(player)
                    self.updateUI()
                }
            }))

            self.present(alert, animated: true, completion: nil)
           
        }
    }
    
    func updateUI() {
        if let savedPlayer = Player.loadPlayer() {
            usernameLabel.text = savedPlayer.username
            numberOfStarsLabel.text = "\(savedPlayer.totalNumberOfStars) ⭐️"
            
            if savedPlayer.endlessGameStatistics.totalSolvedAdditionTasks == 0 {
                additionStatLabel.text = "0 / 0 (0%)"
            } else {
                additionStatLabel.text = "\(savedPlayer.endlessGameStatistics.correctSolvedAdditionTasks) / \(savedPlayer.endlessGameStatistics.totalSolvedAdditionTasks) (\(savedPlayer.endlessGameStatistics.correctSolvedAdditionTasks * 100 / savedPlayer.endlessGameStatistics.totalSolvedAdditionTasks) %)"
            }
            if savedPlayer.endlessGameStatistics.totalSolvedSubtractionTasks == 0 {
                subtractionStstLabel.text = "0 / 0 (0%)"
            } else {
                subtractionStstLabel.text = "\(savedPlayer.endlessGameStatistics.correctSolvedSubtractionTasks) / \(savedPlayer.endlessGameStatistics.totalSolvedSubtractionTasks) (\(savedPlayer.endlessGameStatistics.correctSolvedSubtractionTasks * 100 / savedPlayer.endlessGameStatistics.totalSolvedSubtractionTasks) %)"
            }
            
            if savedPlayer.endlessGameStatistics.totalSolvedMultiplicationTasks == 0 {
                multiplicationStatLabel.text = "0 / 0 (0%)"
            } else {
                multiplicationStatLabel.text = "\(savedPlayer.endlessGameStatistics.correctSolvedMultiplicationTasks) / \(savedPlayer.endlessGameStatistics.totalSolvedMultiplicationTasks) (\(savedPlayer.endlessGameStatistics.correctSolvedMultiplicationTasks * 100 / savedPlayer.endlessGameStatistics.totalSolvedMultiplicationTasks) %)"
            }
            
            if savedPlayer.endlessGameStatistics.totalSolvedDivisionTasks == 0 {
                divisionStatLabel.text = "0 / 0 (0%)"
            } else {
                divisionStatLabel.text = "\(savedPlayer.endlessGameStatistics.correctSolvedDivisionTasks) / \(savedPlayer.endlessGameStatistics.totalSolvedDivisionTasks) (\(savedPlayer.endlessGameStatistics.correctSolvedDivisionTasks * 100 / savedPlayer.endlessGameStatistics.totalSolvedDivisionTasks) %)"
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
