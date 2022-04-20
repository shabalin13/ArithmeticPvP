//
//  Level.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2022.
//

import Foundation

struct Level: Equatable, Codable {
    
    let id: UUID
    let name: String
    let blockID: Int
    let levelID: Int
    let blockName: String
    let typeOfTime: GameTimeType
    let typeOfAnswer: GameAnswersType
    var tasks: [Task]
    var numberOfStars: Int
    var isCompleted: Bool
    var numberOfCorrectAnswers: Int
    var isOnTime: Bool
    
    
    init(tasks: [Task], blockID: Int, levelID: Int, typeOfTime: GameTimeType, typeOfAnswer: GameAnswersType) {
        self.id = UUID()
        if levelID == 4 {
            self.name = "Final Level #\(levelID + 1)"
        } else {
            self.name = "Level #\(levelID + 1)"
        }
        self.numberOfStars = 0
        
        self.blockID = blockID
        self.levelID = levelID
        if blockID == 0 {
            self.blockName = "Additition"
        } else if blockID == 1 {
            self.blockName = "Subtraction"
        } else if blockID == 2 {
            self.blockName = "Additition and Subtraction"
        } else if blockID == 3 {
            self.blockName = "Multiplication"
        } else if blockID == 4 {
            self.blockName = "Multiplication, Additition and Subtraction"
        } else if blockID == 5 {
            self.blockName = "Division"
        } else if blockID == 6 {
            self.blockName = "Division, Additition and Subtraction"
        } else if blockID == 7 {
            self.blockName = "Multiplication and Division"
        } else if blockID == 8 {
            self.blockName = "Additition, Subtraction, Multiplication and Division"
        } else {
            self.blockName = "Some block"
        }
        
        self.tasks = tasks
        self.typeOfTime = typeOfTime
        self.isCompleted = false
        self.typeOfAnswer = typeOfAnswer
        self.numberOfCorrectAnswers = 0
        self.isOnTime = true
    }
    
    static func ==(lhs: Level, rhs: Level) -> Bool {
        return lhs.id == rhs.id
    }
    
}


struct LevelsManager {
    
    static func create40Levels() -> [[Level]] {
        var levels = [[Level]]()
        
        for blockID in 0..<8 {
            var blockLevels = [Level]()
            for levelID in 0..<5 {
                
                if blockID == 0 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.addition], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.addition], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.addition], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 1 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.subtraction], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.subtraction], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.subtraction], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 2 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 3 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.multiplication], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.multiplication], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.multiplication], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 4 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .multiplication], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .multiplication], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .multiplication], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 5 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.division], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.division], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.division], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 6 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .division], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .division], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .division], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 7 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.multiplication, .division], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.multiplication, .division], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.multiplication, .division], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                } else if blockID == 8 {
                    if levelID == 0 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .multiplication, .division], type: .test, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 1 || levelID == 3 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .multiplication, .division], type: .keyboard, blockID: blockID, levelID: levelID), at: levelID)
                    } else if levelID == 2 || levelID == 4 {
                        blockLevels.insert(createLevel(operations: [.addition, .subtraction, .multiplication, .division], type: .random, blockID: blockID, levelID: levelID), at: levelID)
                    }
                }
            }
            levels.insert(blockLevels, at: blockID)
        }
        return levels
    }
    
    
    static func createLevel(operations: [GameOperationsType], type: GameAnswersType, blockID: Int, levelID: Int) -> Level {
        var tasks = [Task]()
        
        var range1: (from: Int, to: Int)
        var range2: (from: Int, to: Int)
        var range3: (from: Int, to: Int)
        var range4: (from: Int, to: Int)
        
        if levelID == 0 {
            range1 = (from: 10, to: 20)
            range2 = (from: 1, to: 10)
            range3 = (from: 4, to: 10)
            range4 = (from: 1, to: 10)
        } else if levelID == 1 {
            range1 = (from: 20, to: 50)
            range2 = (from: 15, to: 35)
            range3 = (from: 7, to: 15)
            range4 = (from: 5, to: 10)
        } else if levelID == 2 {
            range1 = (from: 50, to: 150)
            range2 = (from: 50, to: 100)
            range3 = (from: 15, to: 40)
            range4 = (from: 10, to: 25)
        } else if levelID == 3 {
            range1 = (from: 100, to: 350)
            range2 = (from: 100, to: 250)
            range3 = (from: 30, to: 65)
            range4 = (from: 25, to: 65)
        } else {
            range1 = (from: 150, to: 500)
            range2 = (from: 150, to: 400)
            range3 = (from: 45, to: 100)
            range4 = (from: 30, to: 100)
        }
        
        for _ in 0..<12 {
            tasks.append(TaskManager.createLevelTask(range1: range1, range2: range2, range3: range3, range4: range4, operations: operations, type: type))
        }
        return Level(tasks: tasks, blockID: blockID, levelID: levelID, typeOfTime: .withTime, typeOfAnswer: type)
    }
    
}
