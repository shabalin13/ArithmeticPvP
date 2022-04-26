//
//  Game.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import Foundation

enum GameDifficultyType: Codable {
    case easy, normal, hard, insane
}

enum GameAnswersType: Codable {
    case test, random, keyboard
}

enum GameOperationsType: Codable {
    case addition, subtraction, multiplication, division
}

enum GameTimeType: Codable {
    case withTime, withoutTime
}

struct EndlessGame {
    
    let id: UUID
    var tasks: [Task]
    var player: Player
    var numberOfCorrectAnswers: Int
    let typeOfDifficulty: GameDifficultyType
    let typeOfAnswers: GameAnswersType
    let typeOfTime: GameTimeType
    let operations: [GameOperationsType]
    
    var currentTask: Task {
        get {
            return tasks[tasks.count - 1]
        }
        set(newTask) {
            tasks[tasks.count - 1] = newTask
        }
    }
    
    init(typeOfDifficulty: GameDifficultyType, typeOfAnswers: GameAnswersType, typeOfTime: GameTimeType, operations: [GameOperationsType], player: Player) {
        self.id = UUID()
        
        self.tasks = [Task]()
        
        numberOfCorrectAnswers = 0
        
        self.typeOfDifficulty = typeOfDifficulty
        self.typeOfAnswers = typeOfAnswers
        self.typeOfTime = typeOfTime
        self.operations = operations
        
        self.player = player
    }
    
    mutating func getNewTask() {
        
        if typeOfDifficulty == .easy {
            let newTask = TaskManager.createEasyTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
        } else if typeOfDifficulty == .normal {
            let newTask = TaskManager.createNormalTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
        } else if typeOfDifficulty == .hard {
            let newTask = TaskManager.createHardTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
        } else if typeOfDifficulty == .insane {
            let newTask = TaskManager.createInsaneTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
        }
    }
    
    func getAnswersForTest() -> Set<String> {
        return Set<String>(currentTask.falseAnswers + [currentTask.answer])
    }
    
    mutating func keyboardButtonPressed(keybordButton: String) {
        if let _ = Int(keybordButton) {
            let oldCurrentAnswer = currentTask.currentAnswer
            for (index, elem) in oldCurrentAnswer.enumerated() {
                if elem == "_" {
                    currentTask.currentAnswer[index] = keybordButton
                    break
                }
            }
        } else if keybordButton == "Del" {
            let oldCurrentAnswer = currentTask.currentAnswer
            for (index, elem) in Array(oldCurrentAnswer.reversed()).enumerated() {
                if elem != "_" {
                    currentTask.currentAnswer[currentTask.currentAnswer.count - 1 - index] = "_"
                    break
                }
            }
        }
    }
    
    mutating func testButtonPressed(testButton: String) {
        currentTask.currentAnswer = testButton.map { String($0) }
    }
    
}
