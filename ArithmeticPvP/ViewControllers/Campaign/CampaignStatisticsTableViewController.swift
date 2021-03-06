//
//  CampaignStatisticsTableViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2022.
//

import UIKit

class CampaignStatisticsTableViewController: UITableViewController {

    var playedGame: CampaignGame!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.title = "Statistics: \(playedGame.level.numberOfCorrectAnswers)/\(playedGame.level.tasks.count)"
        updateAllAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setInitial()
        setInitialCurrentAnswers()
        playedGame.player.levels[playedGame.level.blockID][playedGame.level.levelID] = playedGame.level
        updateMaxCompleted()
        updateTotalStars ()
        Player.savePlayer(playedGame.player)
        
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    init?(coder: NSCoder, playedGame: CampaignGame) {
        self.playedGame = playedGame
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayConfirmAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func updateAllAttributes() {
        updateStarsAndCompletness()
    }
    
    func updateTotalStars() {
        var total = 0
        for block in playedGame.player.levels {
            for level in block {
                total += level.numberOfStars
            }
        }
        playedGame.player.totalNumberOfStars = total
    }
    
    func updateMaxCompleted() {
        if playedGame.level.blockID > playedGame.player.maxCompletedBlockID && playedGame.level.isCompleted {
            playedGame.player.maxCompletedBlockID = playedGame.level.blockID
            playedGame.player.maxCompletedLevelID = playedGame.level.levelID
        } else if playedGame.level.blockID == playedGame.player.maxCompletedBlockID && playedGame.level.levelID > playedGame.player.maxCompletedLevelID && playedGame.level.isCompleted {
            playedGame.player.maxCompletedBlockID = playedGame.level.blockID
            playedGame.player.maxCompletedLevelID = playedGame.level.levelID
        }
    }
    
    func setInitial() {
        playedGame.level.isOnTime = true
        playedGame.level.numberOfCorrectAnswers = 0
    }
    
    func setInitialCurrentAnswers() {
        for taskIndex in 0..<playedGame.level.tasks.count {
            playedGame.level.tasks[taskIndex].setInitialCurrentAnswer()
        }
    }
    
    func updateStarsAndCompletness() {
        if playedGame.level.numberOfStars == 0 {
            if playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count && playedGame.level.isOnTime {
                playedGame.level.isCompleted = true
                playedGame.level.numberOfStars = 3
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nYou get ??????????????????!\n")
            } else if (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 1 && playedGame.level.isOnTime) || (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count && !playedGame.level.isOnTime) {
                playedGame.level.isCompleted = true
                playedGame.level.numberOfStars = 2
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nYou get ????????????!\n")
            } else if (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 2 && playedGame.level.isOnTime) || (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 1 && !playedGame.level.isOnTime) {
                playedGame.level.isCompleted = true
                playedGame.level.numberOfStars = 1
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nYou get ??????!\n")
            } else if playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 3 {
                // ???????????????? ????????????, ?????????? ???????? ???????????????????? ??????????????, ???????????????? ?????????????? ??????????????
                playedGame.level.isCompleted = true
                playedGame.level.numberOfStars = 0
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nBut you don't get stars..\n")
            } else {
                playedGame.level.isCompleted = false
                displayConfirmAlert(title: "LOSS!", message: "\nSorry you didn't complete this level. Try again..\n\nYou will definitely succeed!\n")
            }
        } else {
            if playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count && playedGame.level.isOnTime {
                playedGame.level.isCompleted = true
                if playedGame.level.numberOfStars < 3 {
                    playedGame.level.numberOfStars = 3
                }
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nYou get ??????????????????!\n")
            } else if (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 1 && playedGame.level.isOnTime) || (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count && !playedGame.level.isOnTime) {
                playedGame.level.isCompleted = true
                if playedGame.level.numberOfStars < 2 {
                    playedGame.level.numberOfStars = 2
                }
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nYou get ????????????!\n")
            } else if (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 2 && playedGame.level.isOnTime) || (playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 1 && !playedGame.level.isOnTime) {
                playedGame.level.isCompleted = true
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nYou get ??????!\n")
            } else if playedGame.level.numberOfCorrectAnswers == playedGame.level.tasks.count - 3 {
                // ???????????????? ????????????, ?????????? ???????? ???????????????????? ??????????????, ???????????????? ?????????????? ??????????????
                playedGame.level.isCompleted = true
                displayConfirmAlert(title: "CONGRATULATIONS!", message: "\nYou have successfully completed this level!\n\nBut you don't get stars..\n")
            } else {
                displayConfirmAlert(title: "LOSS!", message: "\nSorry you didn't complete this level. Try again..\n\nYou will definitely succeed!\n")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playedGame.level.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CampaignStatisticsCell", for: indexPath) as! CampaignStatisticsTableViewCell
        
        let task = playedGame.level.tasks[indexPath.row]
        cell.configure(task: task)

        return cell
    }
    
}
