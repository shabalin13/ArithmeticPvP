//
//  MultiplayerGame.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 26.04.2022.
//

import Foundation

//struct PvPGame {
struct MultiplayerGame {
    
    let id: UUID
    var guest1: Guest
    var guest2: Guest
    
    let typeOfDifficulty: GameDifficultyType
    let typeOfAnswers: GameAnswersType
    let operations: [GameOperationsType]
    
//    var currentGuestID: Int
//
//    var currentGuest: Guest {
//        get {
//            return guests[currentGuestID]
//        }
//        set(newGuest) {
//            guests[currentGuestID] = newGuest
//        }
//    }
    
    init(typeOfDifficulty: GameDifficultyType, operations: [GameOperationsType], guest1: Guest, guest2: Guest) {
        self.id = UUID()
        self.guest1 = guest1
        self.guest2 = guest2
        
        self.typeOfDifficulty = typeOfDifficulty
        self.typeOfAnswers = .test
        self.operations = operations
    }
    
    mutating func getTasks() {
        for _ in 0...11 {
            if typeOfDifficulty == .easy {
                let newTask = TaskManager.createEasyTask(operations: operations, type: typeOfAnswers)
                guest1.tasks.append(newTask)
                guest2.tasks.append(newTask)
            } else if typeOfDifficulty == .normal {
                let newTask = TaskManager.createNormalTask(operations: operations, type: typeOfAnswers)
                guest1.tasks.append(newTask)
                guest2.tasks.append(newTask)
            } else if typeOfDifficulty == .hard {
                let newTask = TaskManager.createHardTask(operations: operations, type: typeOfAnswers)
                guest1.tasks.append(newTask)
                guest2.tasks.append(newTask)
            } else if typeOfDifficulty == .insane {
                let newTask = TaskManager.createInsaneTask(operations: operations, type: typeOfAnswers)
                guest1.tasks.append(newTask)
                guest2.tasks.append(newTask)
            }
        }
    }
    
    mutating func getGuest1NewTask() -> Bool {
        if guest1.currentTaskID + 1 == guest1.tasks.count {
            return false
        } else {
            guest1.currentTaskID += 1
            return true
        }
    }
    
    mutating func getGuest2NewTask() -> Bool {
        if guest2.currentTaskID + 1 == guest2.tasks.count {
            return false
        } else {
            guest2.currentTaskID += 1
            return true
        }
    }
    
    func getGuest1AnswersForTest() -> Set<String> {
        return Set<String>(guest1.currentTask.falseAnswers + [guest1.currentTask.answer])
    }
    
    func getGuest2AnswersForTest() -> Set<String> {
        return Set<String>(guest2.currentTask.falseAnswers + [guest2.currentTask.answer])
    }
    
    mutating func guest1testButtonPressed(testButton: String) {
        guest1.currentTask.currentAnswer = testButton.map { String($0) }
    }
    
    mutating func guest2testButtonPressed(testButton: String) {
        guest2.currentTask.currentAnswer = testButton.map { String($0) }
    }
    
}
