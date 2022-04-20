//
//  CampaignGame.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2022.
//

import Foundation

struct CampaignGame {
    
    let id: UUID
    var player: Player
    var level: Level
    var currentTaskID: Int
    
    var currentTask: Task {
        get {
            return level.tasks[currentTaskID]
        }
        set(newTask) {
            level.tasks[currentTaskID] = newTask
        }
    }
    
    init(player: Player, level: Level) {
        self.id = UUID()
        self.player = player
        self.level = level
        self.currentTaskID = -1
    }
    
    func setTime() -> (currentTime: Double?, totalTime: Double?){
        var currentTime: Double?
        var totalTime: Double?
        
        if level.typeOfTime == .withoutTime {
            currentTime = nil
            totalTime = nil
        } else if level.typeOfTime == .withTime {
            if level.levelID == 0 {
                currentTime = 12 * 1.5
                totalTime = 12 * 1.5
            } else if level.levelID == 1 {
                currentTime = 12 * 3
                totalTime = 12 * 3
            } else if level.levelID == 2 {
                currentTime = 12 * 8
                totalTime = 12 * 8
            } else if level.levelID == 3 {
                currentTime = 12 * 12
                totalTime = 12 * 12
            } else if level.levelID == 4 {
                currentTime = 12 * 15
                totalTime = 12 * 15
            }
            
        }
        return (currentTime: currentTime, totalTime: totalTime)
    }
    
    mutating func getNewTask() -> Bool {
        if currentTaskID + 1 == level.tasks.count {
            return false
        } else {
            currentTaskID += 1
            return true
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
