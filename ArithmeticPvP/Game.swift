//
//  Game.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import Foundation

struct Game {
    
    let id: UUID
    let startTime: Date
    var endTime: Date?
    let numberOfTasks: Int
    var tasks: [Task]
    var player: Player

    init(endTime: Date?, player: Player) {
        self.id = UUID()
        self.startTime = Date()
        self.endTime = endTime
        self.numberOfTasks = 7
        
        let taskManager = TaskManager()
        
        var tempTasks = [Task]()
        for _ in 1...numberOfTasks {
            let task = taskManager.createEasyTask()
            tempTasks.append(task)
        }
        self.tasks = tempTasks
        
        self.player = player
    }
    
    mutating func isThereTask() -> (isOK: Bool, task: Task?) {
        if !tasks.isEmpty {
            return (true, tasks.removeFirst())
        } else {
            return (false, nil)
        }
    }
    
}
