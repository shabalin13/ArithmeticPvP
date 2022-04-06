//
//  Player.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import Foundation

struct Player: Equatable, Codable {
    let id: UUID
    let username: String
    var avgSpeed: String?
    var totalNumberOfTasksSolved: Int
    var numberOfSolvedTasksInGame: Int
    var numberOfPlayedGames: Int
    var currentTask: Task?
    
    init(username: String, avgSpeed: String? = nil, totalNumberOfTasksSolved: Int = 0, numberOfPlayedGames: Int = 0, numberOfSolvedTasksInGame: Int = 0) {
        self.id = UUID()
        self.username = username
        self.avgSpeed = avgSpeed
        self.totalNumberOfTasksSolved = totalNumberOfTasksSolved
        self.numberOfPlayedGames = numberOfPlayedGames
        self.numberOfSolvedTasksInGame = numberOfSolvedTasksInGame
        self.currentTask = nil
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let documentsDirectory =
    FileManager.default.urls(for: .documentDirectory,
                             in: .userDomainMask).first!
    static let archiveURL =
    documentsDirectory.appendingPathComponent("players")
        .appendingPathExtension("plist")
    
    static func loadPlayer() -> Player? {
        guard let codedPlayer = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Player.self, from: codedPlayer)
    }
    
    static func savePlayer(_ player: Player) {
        let propertyListEncoder = PropertyListEncoder()
        let codedPlayer = try? propertyListEncoder.encode(player)
        try? codedPlayer?.write(to: archiveURL, options: .noFileProtection)
    }
    
    mutating func playerEnter(keybordButton: String) {
        if let _ = Int(keybordButton) {
            let oldCurrentAnswer = currentTask!.currentAnswer
            for (index, elem) in oldCurrentAnswer.enumerated() {
                if elem == "_" {
//                    currentTask!.currentAnswer[index] = Character(keybordButton)
                    currentTask!.currentAnswer[index] = keybordButton
                    break
                }
            }
        } else if keybordButton == "Del" {
            let oldCurrentAnswer = currentTask!.currentAnswer
            for (index, elem) in Array(oldCurrentAnswer.reversed()).enumerated() {
                if elem != "_" {
//                    currentTask!.currentAnswer[currentTask!.currentAnswer.count - 1 - index] = Character("_")
                    currentTask!.currentAnswer[currentTask!.currentAnswer.count - 1 - index] = "_"
                    break
                }
            }

        }
//        else if keybordButton == "-" {
//
//        }
    }
}
