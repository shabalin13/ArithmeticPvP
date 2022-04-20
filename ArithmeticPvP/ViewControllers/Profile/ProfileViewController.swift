//
//  ProfileViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 20.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let savedPlayer = Player.loadPlayer() {
            print("Player exists")
            usernameLabel.text = savedPlayer.username
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
                    self.usernameLabel.text = player.username
                    Player.savePlayer(player)
                }
            }))

            self.present(alert, animated: true, completion: nil)
           
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
