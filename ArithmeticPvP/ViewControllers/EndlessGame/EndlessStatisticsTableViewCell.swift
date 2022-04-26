//
//  StatisticsTableViewCell.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 18.04.2022.
//

import UIKit

class EndlessStatisticsTableViewCell: UITableViewCell {
    
    @IBOutlet var emojiLabel: UILabel!
    @IBOutlet var questionAndAnswerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(task: Task) {
        
        if task.answer == task.stringAnswer {
            emojiLabel.text = "✅"
        } else {
            emojiLabel.text = "❌"
        }
        
        if task.currentAnswer.contains("_"){
            let questionAndLabel = "\(task.question) = \(task.formattedCurentAnswer) (\(task.answer))"
            
            let range1 = (questionAndLabel as NSString).range(of: "= \(task.formattedCurentAnswer)")
            let range2 = (questionAndLabel as NSString).range(of: "(\(task.answer))")
            
            let attributedText = NSMutableAttributedString.init(string: questionAndLabel)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: range1.location + 2, length: range1.length - 2))
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: range2)
            
            questionAndAnswerLabel.attributedText = attributedText
            
        } else if task.stringAnswer != task.answer {
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
        
    }
}
