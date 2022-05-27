//
//  MultiplayerStatisticsTableViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 26.04.2022.
//

import UIKit

class MultiplayerStatisticsTableViewController: UITableViewController {
    
    var playedGame: MultiplayerGame!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    init?(coder: NSCoder, playedGame: MultiplayerGame) {
        self.playedGame = playedGame
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return playedGame.guest1.tasks.count + 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MultiplayerStatisticsCell", for: indexPath) as! MultiplayerStatisticsTableViewCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.configurePlace(currentGuest: playedGame.guest1, anotherGuest: playedGame.guest2)
            } else if indexPath.row == 1 {
                cell.configurePlace(currentGuest: playedGame.guest2, anotherGuest: playedGame.guest1)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.configure(guest: playedGame.guest1)
            } else if indexPath.row == 1{
                cell.configure(guest: playedGame.guest2)
            }
        } else {
            if indexPath.row == 0 {
                let task = playedGame.guest1.tasks[indexPath.section - 2]
                cell.configure(task: task, guestName: playedGame.guest1.username)
            } else if indexPath.row == 1 {
                let task = playedGame.guest2.tasks[indexPath.section - 2]
                cell.configure(task: task, guestName: playedGame.guest2.username)
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Places"
        } else if section == 1 {
            return "Correct Answers and Solving Time"
        } else {
            return "Task #\(section - 1)"
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.section, indexPath.row)
//    }

}
