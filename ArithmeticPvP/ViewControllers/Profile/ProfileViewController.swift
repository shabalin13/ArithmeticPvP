//
//  ProfileViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 20.04.2022.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var numberOfStarsLabel: UILabel!
    @IBOutlet var additionStatLabel: UILabel!
    @IBOutlet var subtractionStstLabel: UILabel!
    @IBOutlet var multiplicationStatLabel: UILabel!
    @IBOutlet var divisionStatLabel: UILabel!
    @IBOutlet var userPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPhoto.layer.cornerRadius = 70
        userPhoto.clipsToBounds = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = Player.loadPlayer() {
//            print("Player exists")
            updateUI()
        } else {
//            print("Player does not exist")
            let alert = UIAlertController(title: "Create User", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in textField.placeholder = "Username"}
            
            alert.addAction(UIAlertAction(title: "CREATE", style: .default, handler: { (_) in
                let textField = alert.textFields![0]
                if textField.text == "" {
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let player = Player(username: textField.text!)
//                    print("Player created")
                    Player.savePlayer(player)
                    self.updateUI()
                }
            }))

            self.present(alert, animated: true, completion: nil)
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    func updateUI() {
        if let savedPlayer = Player.loadPlayer() {
            usernameLabel.text = savedPlayer.username
            if let userImage = savedPlayer.userPhoto {
                userPhoto.image = UIImage(data: userImage)
            } else {
                userPhoto.image = UIImage(systemName: "person.circle")
            }
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
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source to update users's photo", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
    
//        alertController.popoverPresentationController?.sourceView = sender
    
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        if var savedPlayer = Player.loadPlayer() {
            savedPlayer.userPhoto = selectedImage.jpegData(compressionQuality: 1)
            Player.savePlayer(savedPlayer)
        }
        
        updateUI()
        dismiss(animated: true, completion: nil)
    }
    
    
}
