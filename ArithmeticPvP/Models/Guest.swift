//
//  Guest.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 26.04.2022.
//

import Foundation

struct Guest {
    
    let id: UUID
    let username: String
    var tasks: [Task]
    var numberOfSolvedTasksInGame: Int
    var numberOfCorrectTasksInGame: Int
    
    var startTime: Date?
    var endTime: Date?
    
    var currentTaskID: Int
    
    var currentTask: Task {
        get {
            return tasks[currentTaskID]
        }
        set(newTask) {
            tasks[currentTaskID] = newTask
        }
    }
    
    init(username: String) {
        self.id = UUID()
        self.username = username
        self.tasks = [Task]()
        self.currentTaskID = -1
        self.numberOfSolvedTasksInGame = 0
        self.numberOfCorrectTasksInGame = 0
    }
}
