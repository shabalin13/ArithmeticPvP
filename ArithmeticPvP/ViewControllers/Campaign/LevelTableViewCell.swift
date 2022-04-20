//
//  LevelTableViewCell.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2022.
//

import UIKit

class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet var checkmarkImage: UIImageView!
    @IBOutlet var levelNameLabel: UILabel!
    @IBOutlet var starImage1: UIImageView!
    @IBOutlet var starImage2: UIImageView!
    @IBOutlet var starImage3: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(level: Level) {
        
        if !level.isCompleted {
//            emojiLabel.isHidden = true
//            emojiLabel.text = ""
            let checkmarkImageConfig = UIImage.SymbolConfiguration(scale: .large)
            checkmarkImage.image = UIImage(systemName: "circle", withConfiguration: checkmarkImageConfig)
            checkmarkImage.tintColor = UIColor.secondaryLabel
        } else {
//            emojiLabel.text = "✅"
            let checkmarkImageConfig = UIImage.SymbolConfiguration(scale: .large)
            checkmarkImage.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: checkmarkImageConfig)
            checkmarkImage.tintColor = UIColor.systemGreen
        }
        
        levelNameLabel.text = level.name
        
        if level.numberOfStars == 0 {
            let starImage1Config = UIImage.SymbolConfiguration(scale: .small)
            starImage1.image = UIImage(systemName: "star.fill", withConfiguration: starImage1Config)
            starImage1.tintColor = UIColor.secondaryLabel
            
            let starImage2Config = UIImage.SymbolConfiguration(scale: .medium)
            starImage2.image = UIImage(systemName: "star.fill", withConfiguration: starImage2Config)
            starImage2.tintColor = UIColor.secondaryLabel
            
            let starImage3Config = UIImage.SymbolConfiguration(scale: .large)
            starImage3.image = UIImage(systemName: "star.fill", withConfiguration: starImage3Config)
            starImage3.tintColor = UIColor.secondaryLabel
            
        } else if level.numberOfStars == 1 {
            let starImage1Config = UIImage.SymbolConfiguration(scale: .small)
            starImage1.image = UIImage(systemName: "star.fill", withConfiguration: starImage1Config)
//            starImage1.tintColor = UIColor(red: 245/255.0, green: 216/255.0, blue: 86/255.0, alpha: 1)
            starImage1.tintColor = UIColor.systemOrange
            
            let starImage2Config = UIImage.SymbolConfiguration(scale: .medium)
            starImage2.image = UIImage(systemName: "star.fill", withConfiguration: starImage2Config)
            starImage2.tintColor = UIColor.secondaryLabel
            
            let starImage3Config = UIImage.SymbolConfiguration(scale: .large)
            starImage3.image = UIImage(systemName: "star.fill", withConfiguration: starImage3Config)
            starImage3.tintColor = UIColor.secondaryLabel
            
        } else if level.numberOfStars == 2 {
            let starImage1Config = UIImage.SymbolConfiguration(scale: .small)
            starImage1.image = UIImage(systemName: "star.fill", withConfiguration: starImage1Config)
//            starImage1.tintColor = UIColor(red: 245/255.0, green: 216/255.0, blue: 86/255.0, alpha: 1)
            starImage1.tintColor = UIColor.systemOrange
            
            let starImage2Config = UIImage.SymbolConfiguration(scale: .medium)
            starImage2.image = UIImage(systemName: "star.fill", withConfiguration: starImage2Config)
//            starImage2.tintColor = UIColor(red: 245/255.0, green: 216/255.0, blue: 86/255.0, alpha: 1)
            starImage2.tintColor = UIColor.systemOrange
            
            let starImage3Config = UIImage.SymbolConfiguration(scale: .large)
            starImage3.image = UIImage(systemName: "star.fill", withConfiguration: starImage3Config)
            starImage3.tintColor = UIColor.secondaryLabel
            
        } else if level.numberOfStars == 3 {
            let starImage1Config = UIImage.SymbolConfiguration(scale: .small)
            starImage1.image = UIImage(systemName: "star.fill", withConfiguration: starImage1Config)
//            starImage1.tintColor = UIColor(red: 245/255.0, green: 216/255.0, blue: 86/255.0, alpha: 1)
            starImage1.tintColor = UIColor.systemOrange
            
            let starImage2Config = UIImage.SymbolConfiguration(scale: .medium)
            starImage2.image = UIImage(systemName: "star.fill", withConfiguration: starImage2Config)
//            starImage2.tintColor = UIColor(red: 245/255.0, green: 216/255.0, blue: 86/255.0, alpha: 1)
            starImage2.tintColor = UIColor.systemOrange
            
            let starImage3Config = UIImage.SymbolConfiguration(scale: .large)
            starImage3.image = UIImage(systemName: "star.fill", withConfiguration: starImage3Config)
//            starImage3.tintColor = UIColor(red: 245/255.0, green: 216/255.0, blue: 86/255.0, alpha: 1)
            starImage3.tintColor = UIColor.systemOrange
            
        }
        
    }

}
