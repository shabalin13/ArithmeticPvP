//
//  EndlessGameStatisticsTableViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.04.2022.
//

import UIKit

class EndlessStatisticsTableViewController: UITableViewController {
    
    var playedGame: EndlessGame!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.title = "Statistics: \(playedGame.numberOfCorrectAnswers)/\(playedGame.tasks.count)"
        
        updateStatistics()
    }
    
    init?(coder: NSCoder, playedGame: EndlessGame) {
        self.playedGame = playedGame
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStatistics() {
        for task in playedGame.tasks {
            if task.sign == .addition {
                if task.answer == task.stringAnswer {
                    playedGame.player.endlessGameStatistics.incrementCorrectAdd()
                } else {
                    playedGame.player.endlessGameStatistics.incrementAddTotal()
                }
            } else if task.sign == .subtraction {
                if task.answer == task.stringAnswer {
                    playedGame.player.endlessGameStatistics.incrementCorrectSub()
                } else {
                    playedGame.player.endlessGameStatistics.incrementSubTotal()
                }
            } else if task.sign == .multiplication {
                if task.answer == task.stringAnswer {
                    playedGame.player.endlessGameStatistics.incrementCorrectMult()
                } else {
                    playedGame.player.endlessGameStatistics.incrementMultTotal()
                }
            } else if task.sign == .division {
                if task.answer == task.stringAnswer {
                    playedGame.player.endlessGameStatistics.incrementCorrectDiv()
                } else {
                    playedGame.player.endlessGameStatistics.incrementDivTotal()
                }
            }
        }
        Player.savePlayer(playedGame.player)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playedGame.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EndlessStatisticsCell", for: indexPath) as! EndlessStatisticsTableViewCell
        
        let task = playedGame.tasks[indexPath.row]
        cell.configure(task: task)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
