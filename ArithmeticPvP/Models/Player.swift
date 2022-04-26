//
//  Player.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import UIKit

struct Player: Equatable, Codable {
    
    let id: UUID
    let username: String
    var levels: [[Level]]
    var maxCompletedBlockID: Int
    var maxCompletedLevelID: Int
    var totalNumberOfStars: Int
    var endlessGameStatistics: Stat
    var userPhoto: Data?
    
    struct Stat: Codable {
        var correctSolvedAdditionTasks: Int
        var totalSolvedAdditionTasks: Int
        
        var correctSolvedSubtractionTasks: Int
        var totalSolvedSubtractionTasks: Int
        
        var correctSolvedMultiplicationTasks: Int
        var totalSolvedMultiplicationTasks: Int
        
        var correctSolvedDivisionTasks: Int
        var totalSolvedDivisionTasks: Int
        
        init() {
            self.correctSolvedAdditionTasks = 0
            self.totalSolvedAdditionTasks = 0
            
            self.correctSolvedSubtractionTasks = 0
            self.totalSolvedSubtractionTasks = 0
            
            self.correctSolvedMultiplicationTasks = 0
            self.totalSolvedMultiplicationTasks = 0
            
            self.correctSolvedDivisionTasks = 0
            self.totalSolvedDivisionTasks = 0
        }
        
        mutating func incrementCorrectAdd() {
            correctSolvedAdditionTasks += 1
            totalSolvedAdditionTasks += 1
        }
        
        mutating func incrementAddTotal() {
            totalSolvedAdditionTasks += 1
        }
        
        mutating func incrementCorrectSub() {
            correctSolvedSubtractionTasks += 1
            totalSolvedSubtractionTasks += 1
        }
        
        mutating func incrementSubTotal() {
            totalSolvedSubtractionTasks += 1
        }
        
        mutating func incrementCorrectMult() {
            correctSolvedMultiplicationTasks += 1
            totalSolvedMultiplicationTasks += 1
        }
        
        mutating func incrementMultTotal() {
            totalSolvedMultiplicationTasks += 1
        }
        
        mutating func incrementCorrectDiv() {
            correctSolvedDivisionTasks += 1
            totalSolvedDivisionTasks += 1
        }
        
        mutating func incrementDivTotal() {
            totalSolvedDivisionTasks += 1
        }
        
    }
    
    var lastLevelIDs: (blockID: Int, levelID: Int) {
        get {
            return (maxCompletedBlockID, maxCompletedLevelID)
        }
        set(newLevelIDs) {
            maxCompletedBlockID = newLevelIDs.blockID
            maxCompletedLevelID = newLevelIDs.levelID
        }
    }
    
    init(username: String) {
        self.id = UUID()
        self.username = username
        self.levels = LevelsManager.create40Levels()
        self.maxCompletedBlockID = 0
        self.maxCompletedLevelID = -1
        self.totalNumberOfStars = 0
        self.endlessGameStatistics = Stat()
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
    
}
