//
//  CampaignTableViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2022.
//

import UIKit

class CampaignLevelsTableViewController: UITableViewController {
    
    var player: Player!
    var selectedBlockID: Int?
    var selectedLevelID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedPlayer = Player.loadPlayer() {
            player = savedPlayer
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
        if let savedPlayer = Player.loadPlayer() {
            player = savedPlayer
        }
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayConfirmAlert(title: String, message: String, blockID: Int, levelID: Int) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Start", style: .default, handler: {
            _ in self.startLevel(blockID: blockID, levelID: levelID)
        }))
        
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
//            self.tableView.deselectRow(at: IndexPath(row: levelID, section: blockID), animated: true)
//        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
        present(alertController, animated: true, completion: nil)
    }
    
    func startLevel(blockID: Int, levelID: Int) {
        selectedBlockID = blockID
        selectedLevelID = levelID
        performSegue(withIdentifier: "StartCampaignGame", sender: nil)
    }
    
    @IBAction func unwindToCampaignLevelsTable(segue: UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StartCampaignGame") {
            if let endlessGameVC = segue.destination as? CampaignGameViewController {
                endlessGameVC.game = CampaignGame(player: player, level: player.levels[selectedBlockID!][selectedLevelID!])
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return player.levels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.levels[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return player.levels[section][0].blockName
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell
        
        cell.backgroundColor = UIColor(red: 213/255.0, green: 231/255.0, blue: 253/255.0, alpha: 1)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 179/255.0, green: 210/255.0, blue: 251/255.0, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        cell.configure(level: player.levels[indexPath.section][indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLevel = player.levels[indexPath.section][indexPath.row]
        
//        print("Section: \(indexPath.section), Row: \(indexPath.row)")
//        print("BlockID: \(player.maxCompletedBlockID), LevelID: \(player.maxCompletedLevelID)")
        
        if player.maxCompletedBlockID * 5 + player.maxCompletedLevelID + 1 >= indexPath.section * 5 + indexPath.row {
            displayConfirmAlert(title: "Do you want to start \(selectedLevel.name)?", message: "", blockID: indexPath.section, levelID: indexPath.row)
        } else {
            displayError(title: "Sorry you can't skip levels!", message: "")
        }
    }

}
