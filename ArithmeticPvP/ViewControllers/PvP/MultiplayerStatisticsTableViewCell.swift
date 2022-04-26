//
//  MultiplayerStatisticsTableViewCell.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 26.04.2022.
//

import UIKit

class MultiplayerStatisticsTableViewCell: UITableViewCell {

    @IBOutlet var emojiLabel: UILabel!
    @IBOutlet var questionAndAnswerLabel: UILabel!
    @IBOutlet var guestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(task: Task, guestName: String) {
        
        emojiLabel.isHidden = false
        questionAndAnswerLabel.isHidden = false
        guestLabel.isHidden = false
        emojiLabel.font = emojiLabel.font.withSize(20)
        questionAndAnswerLabel.font = questionAndAnswerLabel.font.withSize(20)
        guestLabel.font = guestLabel.font.withSize(18)
        
        if task.answer == task.stringAnswer {
            emojiLabel.text = "✅"
        } else {
            emojiLabel.text = "❌"
        }
        
        if task.stringAnswer != task.answer {
            let questionAndLabel = "\(task.question) = \(task.stringAnswer) (\(task.answer))"
            
            let range1 = (questionAndLabel as NSString).range(of: "= \(task.stringAnswer)")
            let range2 = (questionAndLabel as NSString).range(of: "(\(task.answer))")
            
            let attributedText = NSMutableAttributedString.init(string: questionAndLabel)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: range1.location + 2, length: range1.length - 2))
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: range2)
            
            questionAndAnswerLabel.attributedText = attributedText
        } else {
            let questionAndLabel = "\(task.question) = \(task.stringAnswer)"
            
            let range = (questionAndLabel as NSString).range(of: "= \(task.stringAnswer)")
            
            let attributedText = NSMutableAttributedString.init(string: questionAndLabel)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: range.location + 2, length: range.length - 2))
            
            questionAndAnswerLabel.attributedText = attributedText
        }
        
        guestLabel.text = guestName
        
    }
    
    func configure(guest: Guest) {
        
        emojiLabel.isHidden = false
        questionAndAnswerLabel.isHidden = false
        guestLabel.isHidden = false
        emojiLabel.font = emojiLabel.font.withSize(18)
        questionAndAnswerLabel.font = questionAndAnswerLabel.font.withSize(18)
        guestLabel.font = guestLabel.font.withSize(18)
        
        emojiLabel.text = "\(guest.numberOfCorrectTasksInGame) / \(guest.numberOfSolvedTasksInGame) tasks"
//        emojiLabel.font = emojiLabel.font.withSize(18)
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute, .second], from: guest.startTime!, to: guest.endTime!)
        let minutes = components.minute
        let seconds = components.second
        
        
        questionAndAnswerLabel.text = "(\(minutes!) min. \(seconds!) sec.)"
//        questionAndAnswerLabel.font = questionAndAnswerLabel.font.withSize(18)
        
        guestLabel.text = guest.username
    }
    
    func configurePlace(currentGuest: Guest, anotherGuest: Guest) {
        
        emojiLabel.font = emojiLabel.font.withSize(22)
        questionAndAnswerLabel.font = questionAndAnswerLabel.font.withSize(22)
        guestLabel.isHidden = true
        
        if currentGuest.numberOfCorrectTasksInGame > anotherGuest.numberOfCorrectTasksInGame {
            emojiLabel.text = "1️⃣"
        } else if currentGuest.numberOfCorrectTasksInGame == anotherGuest.numberOfCorrectTasksInGame {
            if currentGuest.endTime!.timeIntervalSince(currentGuest.startTime!) <= anotherGuest.endTime!.timeIntervalSince(anotherGuest.startTime!) {
                emojiLabel.text = "1️⃣"
            } else {
                emojiLabel.text = "2️⃣"
            }
        } else {
            emojiLabel.text = "2️⃣"
        }
        
        questionAndAnswerLabel.text = currentGuest.username
    }

}
