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
    var levels: [[Level]]
    var maxCompletedBlockID: Int
    var maxCompletedLevelID: Int
    var totalNumberOfStars: Int
    var endlessGameStatistics: Stat
    
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


//struct Player1: Equatable, Codable {
//    let id: UUID
//    let username: String
//    var avgSpeed: String?
//    var totalNumberOfTasksSolved: Int
//    var numberOfSolvedTasksInGame: Int
//    var numberOfPlayedGames: Int
//    var currentTask: Task?
//
//    init(username: String, avgSpeed: String? = nil, totalNumberOfTasksSolved: Int = 0, numberOfPlayedGames: Int = 0, numberOfSolvedTasksInGame: Int = 0) {
//        self.id = UUID()
//        self.username = username
//        self.avgSpeed = avgSpeed
//        self.totalNumberOfTasksSolved = totalNumberOfTasksSolved
//        self.numberOfPlayedGames = numberOfPlayedGames
//        self.numberOfSolvedTasksInGame = numberOfSolvedTasksInGame
//        self.currentTask = nil
//    }
//
//    static func ==(lhs: Player1, rhs: Player1) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    static let documentsDirectory =
//    FileManager.default.urls(for: .documentDirectory,
//                             in: .userDomainMask).first!
//    static let archiveURL =
//    documentsDirectory.appendingPathComponent("players")
//        .appendingPathExtension("plist")
//
//    static func loadPlayer() -> Player? {
//        guard let codedPlayer = try? Data(contentsOf: archiveURL) else {return nil}
//        let propertyListDecoder = PropertyListDecoder()
//        return try? propertyListDecoder.decode(Player.self, from: codedPlayer)
//    }
//
//    static func savePlayer(_ player: Player) {
//        let propertyListEncoder = PropertyListEncoder()
//        let codedPlayer = try? propertyListEncoder.encode(player)
//        try? codedPlayer?.write(to: archiveURL, options: .noFileProtection)
//    }
//
//}


//static let documentsDirectory =
//FileManager.default.urls(for: .documentDirectory,
//                         in: .userDomainMask).first!
//static let archiveURL =
//documentsDirectory.appendingPathComponent("levels")
//    .appendingPathExtension("plist")
//
//static func loadLevels() -> [Level]? {
//    guard let codedLevels = try? Data(contentsOf: archiveURL) else {return nil}
//    let propertyListDecoder = PropertyListDecoder()
//    return try? propertyListDecoder.decode(Array<Level>.self, from: codedLevels)
//}
//
//static func saveLevels(_ levels: [Level]) {
//    let propertyListEncoder = PropertyListEncoder()
//    let codedPlayer = try? propertyListEncoder.encode(levels)
//    try? codedPlayer?.write(to: archiveURL, options: .noFileProtection)
//}



//mutating func playerEnter(keybordButton: String) {
//    if let _ = Int(keybordButton) {
//        let oldCurrentAnswer = currentTask!.currentAnswer
//        for (index, elem) in oldCurrentAnswer.enumerated() {
//            if elem == "_" {
//                currentTask!.currentAnswer[index] = keybordButton
//                break
//            }
//        }
//    } else if keybordButton == "Del" {
//        let oldCurrentAnswer = currentTask!.currentAnswer
//        for (index, elem) in Array(oldCurrentAnswer.reversed()).enumerated() {
//            if elem != "_" {
//                currentTask!.currentAnswer[currentTask!.currentAnswer.count - 1 - index] = "_"
//                break
//            }
//        }
//
//    }
//}
