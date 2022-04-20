//
//  Game.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import Foundation

//struct Game {
//
//    let id: UUID
//    let startTime: Date
//    var endTime: Date?
//    let numberOfTasks: Int
//    var tasks: [Task]
//    var player: Player
//
//    init(endTime: Date?, player: Player) {
//        self.id = UUID()
//        self.startTime = Date()
//        self.endTime = endTime
//        self.numberOfTasks = 7
//
//        let taskManager = TaskManager()
//
//        var tempTasks = [Task]()
//        for _ in 1...numberOfTasks {
//            let task = taskManager.createEasyTask()
//            tempTasks.append(task)
//        }
//        self.tasks = tempTasks
//
//        self.player = player
//    }
//
//    mutating func isThereTask() -> (isOK: Bool, task: Task?) {
//        if !tasks.isEmpty {
//            return (true, tasks.removeFirst())
//        } else {
//            return (false, nil)
//        }
//    }
//
//}

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
//    var numberOfCompletedTasks: Int
//    var numberOfTasks: Int
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
    
    
    init(typeOfDifficulty: GameDifficultyType, typeOfAnswers: GameAnswersType, typeOfTime: GameTimeType, operations: [GameOperationsType]) {
        self.id = UUID()
        
        if let savedPlayer = Player.loadPlayer() {
            self.player = savedPlayer
        } else {
            self.player = Player(username: "DIMbI4")
        }
        
        self.tasks = [Task]()
        
        numberOfCorrectAnswers = 0
        
        self.typeOfDifficulty = typeOfDifficulty
        self.typeOfAnswers = typeOfAnswers
        self.typeOfTime = typeOfTime
        self.operations = operations
        
//        self.currentTask = nil
    }
    
    mutating func getNewTask() {
        
        if typeOfDifficulty == .easy {
            let newTask = TaskManager.createEasyTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
//            currentTask = newTask
        } else if typeOfDifficulty == .normal {
            let newTask = TaskManager.createNormalTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
//            currentTask = newTask
        } else if typeOfDifficulty == .hard {
            let newTask = TaskManager.createHardTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
//            currentTask = newTask
        } else if typeOfDifficulty == .insane {
            let newTask = TaskManager.createInsaneTask(operations: operations, type: typeOfAnswers)
            tasks.append(newTask)
//            currentTask = newTask
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
