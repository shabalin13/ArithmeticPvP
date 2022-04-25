//
//  Task.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import Foundation

//struct Task: Equatable, Codable {
//    let id: UUID
//    let question: String
//    let answer: String
//    var currentAnswer: [String]
//
//    init(question: String, answer: String) {
//        self.id = UUID()
//        self.question = question
//        self.answer = answer
//
//        var tempAnswer = [String]()
//        for _ in 0..<answer.count {
//            tempAnswer.append("_")
//        }
//        self.currentAnswer = tempAnswer
//    }
//
//    static func ==(lhs: Task, rhs: Task) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//
//    var formattedCurentAnswer: String {
//        let StringCurrentAnswer = currentAnswer
////        for char in currentAnswer {
////            StringCurrentAnswer.append(String(char))
////        }
//        return StringCurrentAnswer.joined(separator: " ")
//    }
//
//    mutating func updateChar(index: Int, char: String) {
//        currentAnswer[index] = char
//    }
//
//}

struct Task: Equatable, Codable {
    
    let id: UUID
    let question: String
    let type: GameAnswersType
    let answer: String
    let falseAnswers: [String]
    var currentAnswer: [String]
    var sign: GameOperationsType
    
    init(question: String, type: GameAnswersType, answer: String, falseAnswers: [String], sign: GameOperationsType) {
        self.id = UUID()
        self.question = question
        self.type = type
        self.answer = answer
        self.falseAnswers = falseAnswers
        self.sign = sign
        
        var tempAnswer = [String]()
        for _ in 0..<answer.count {
            tempAnswer.append("_")
        }
        self.currentAnswer = tempAnswer
    }
    
    var formattedCurentAnswer: String {
        let StringCurrentAnswer = currentAnswer
        return StringCurrentAnswer.joined(separator: " ")
    }
    
    var stringAnswer: String {
        let StringCurrentAnswer = currentAnswer
        return StringCurrentAnswer.joined(separator: "")
    }
    
    mutating func updateChar(index: Int, char: String) {
        currentAnswer[index] = char
    }
    
    mutating func setInitialCurrentAnswer() {
        var tempAnswer = [String]()
        for _ in 0..<answer.count {
            tempAnswer.append("_")
        }
        currentAnswer = tempAnswer
    }
    
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
}


struct TaskManager {
    
    static func choose3FalseAnswers(sign: GameOperationsType, number1: Int, number2: Int) -> [String] {
        var falseAnswers = Set<String>()
        
        if sign == .addition {
            falseAnswers.insert("\(abs(number1 - number2))")
            var tempfalseAnswers = [String](["\(number1 + number2 - 2)", "\(number1 + number2 - 1)", "\(number1 + number2 + 1)", "\(number1 + number2 + 2)"])
            while falseAnswers.count < 3 {
                falseAnswers.insert(tempfalseAnswers.remove(at: Int.random(in: 0..<tempfalseAnswers.count)))
            }
        } else if sign == .subtraction {
            falseAnswers.insert("\(abs(number1 + number2 + number2))")
            var tempfalseAnswers = [String](["\(number1 - 2)", "\(number1 - 1)", "\(number1 + 1)", "\(number1 + 2)"])
            while falseAnswers.count < 3 {
                falseAnswers.insert(tempfalseAnswers.remove(at: Int.random(in: 0..<tempfalseAnswers.count)))
            }
        } else if sign == .multiplication {
            var tempfalseAnswers = [String](["\(number1 * number2 - 3)", "\(number1 * number2 - 2)", "\(number1 * number2 - 1)", "\(number1 * number2 + 1)", "\(number1 * number2 + 2)", "\(number1 * number2 + 3)"])
            while falseAnswers.count < 3 {
                falseAnswers.insert(tempfalseAnswers.remove(at: Int.random(in: 0..<tempfalseAnswers.count)))
            }
        } else if sign == .division {
            var tempfalseAnswers = [String](["\(number1 - 3)", "\(number1 - 2)", "\(number1 - 1)", "\(number1 + 1)", "\(number1 + 2)", "\(number1 + 3)"])
            while falseAnswers.count < 3 {
                falseAnswers.insert(tempfalseAnswers.remove(at: Int.random(in: 0..<tempfalseAnswers.count)))
            }
        }
        return Array(falseAnswers)
    }
    
    static func createEasyTask(operations: [GameOperationsType], type: GameAnswersType) -> Task {
        let sign = operations[Int.random(in: 0..<operations.count)]
        
        var number1: Int = 0
        var number2: Int = 0
        var question: String = ""
        var answer: Int = 0
        var falseAnswers = [String]()
        
        if sign == .addition {
            number1 = Int.random(in: 5...30)
            number2 = Int.random(in: 5...30)
            question = "\(number1) + \(number2)"
            answer = number1 + number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .subtraction {
            number1 = Int.random(in: 5...30)
            number2 = Int.random(in: 5...30)
            question = "\(number1 + number2) - \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .multiplication {
            number1 = Int.random(in: 3...10)
            number2 = Int.random(in: 1...10)
            question = "\(number1) * \(number2)"
            answer = number1 * number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .division {
            number1 = Int.random(in: 4...10)
            number2 = Int.random(in: 1...10)
            question = "\(number1 * number2) / \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        }
        
        if type == .random {
            let isTest = Int.random(in: 0...1)
            if isTest == 0 {
                return Task(question: question, type: .keyboard, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            } else {
                return Task(question: question, type: .test, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            }
        }
        
        return Task(question: question, type: type, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
    }
    
    static func createNormalTask(operations: [GameOperationsType], type: GameAnswersType) -> Task {
        let sign = operations[Int.random(in: 0..<operations.count)]
        
        var number1: Int = 0
        var number2: Int = 0
        var question: String = ""
        var answer: Int = 0
        var falseAnswers = [String]()
        
        if sign == .addition {
            number1 = Int.random(in: 50...150)
            number2 = Int.random(in: 50...150)
            question = "\(number1) + \(number2)"
            answer = number1 + number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .subtraction {
            number1 = Int.random(in: 50...150)
            number2 = Int.random(in: 50...150)
            question = "\(number1 + number2) - \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .multiplication {
            number1 = Int.random(in: 15...25)
            number2 = Int.random(in: 5...10)
            question = "\(number1) * \(number2)"
            answer = number1 * number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .division {
            number1 = Int.random(in: 10...20)
            number2 = Int.random(in: 5...10)
            question = "\(number1 * number2) / \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        }
        
        if type == .random {
            let isTest = Int.random(in: 0...1)
            if isTest == 0 {
                return Task(question: question, type: .keyboard, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            } else {
                return Task(question: question, type: .test, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            }
        }
        
        return Task(question: question, type: type, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
    }
    
    static func createHardTask(operations: [GameOperationsType], type: GameAnswersType) -> Task {
        let sign = operations[Int.random(in: 0..<operations.count)]
        
        var number1: Int = 0
        var number2: Int = 0
        var question: String = ""
        var answer: Int = 0
        var falseAnswers = [String]()
        
        if sign == .addition {
            number1 = Int.random(in: 150...500)
            number2 = Int.random(in: 150...500)
            question = "\(number1) + \(number2)"
            answer = number1 + number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .subtraction {
            number1 = Int.random(in: 150...500)
            number2 = Int.random(in: 150...500)
            question = "\(number1 + number2) - \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .multiplication {
            number1 = Int.random(in: 10...50)
            number2 = Int.random(in: 10...50)
            question = "\(number1) * \(number2)"
            answer = number1 * number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .division {
            number1 = Int.random(in: 25...50)
            number2 = Int.random(in: 10...25)
            question = "\(number1 * number2) / \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        }
        
        if type == .random {
            let isTest = Int.random(in: 0...1)
            if isTest == 0 {
                return Task(question: question, type: .keyboard, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            } else {
                return Task(question: question, type: .test, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            }
        }
        
        return Task(question: question, type: type, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
    }
    
    static func createInsaneTask(operations: [GameOperationsType], type: GameAnswersType) -> Task {
        let sign = operations[Int.random(in: 0..<operations.count)]
        
        var number1: Int = 0
        var number2: Int = 0
        var question: String = ""
        var answer: Int = 0
        var falseAnswers = [String]()
        
        if sign == .addition {
            number1 = Int.random(in: 1000...4900)
            number2 = Int.random(in: 1000...4900)
            question = "\(number1) + \(number2)"
            answer = number1 + number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .subtraction {
            number1 = Int.random(in: 1000...4900)
            number2 = Int.random(in: 1000...4900)
            question = "\(number1 + number2) - \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .multiplication {
            number1 = Int.random(in: 50...150)
            number2 = Int.random(in: 50...150)
            question = "\(number1) * \(number2)"
            answer = number1 * number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .division {
            number1 = Int.random(in: 70...150)
            number2 = Int.random(in: 15...50)
            question = "\(number1 * number2) / \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        }
        
        if type == .random {
            let isTest = Int.random(in: 0...1)
            if isTest == 0 {
                return Task(question: question, type: .keyboard, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            } else {
                return Task(question: question, type: .test, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            }
        }
        
        return Task(question: question, type: type, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
    }
    
    static func createLevelTask(range1: (from: Int, to: Int), range2: (from: Int, to: Int), range3: (from: Int, to: Int), range4: (from: Int, to: Int), operations: [GameOperationsType], type: GameAnswersType) -> Task {
        let sign = operations[Int.random(in: 0..<operations.count)]
        
        var number1: Int = 0
        var number2: Int = 0
        var question: String = ""
        var answer: Int = 0
        var falseAnswers = [String]()
        
        if sign == .addition {
            number1 = Int.random(in: range1.from...range1.to)
            number2 = Int.random(in: range2.from...range2.to)
            question = "\(number1) + \(number2)"
            answer = number1 + number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .subtraction {
            number1 = Int.random(in: range1.from...range1.to)
            number2 = Int.random(in: range2.from...range2.to)
            question = "\(number1 + number2) - \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .multiplication {
            number1 = Int.random(in: range3.from...range3.to)
            number2 = Int.random(in: range4.from...range4.to)
            question = "\(number1) * \(number2)"
            answer = number1 * number2
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        } else if sign == .division {
            number1 = Int.random(in: range3.from...range3.to)
            number2 = Int.random(in: range4.from...range4.to)
            question = "\(number1 * number2) / \(number2)"
            answer = number1
            falseAnswers = choose3FalseAnswers(sign: sign, number1: number1, number2: number2)
        }
        
        if type == .random {
            let isTest = Int.random(in: 0...1)
            if isTest == 0 {
                return Task(question: question, type: .keyboard, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            } else {
                return Task(question: question, type: .test, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)
            }
        }
        
        return Task(question: question, type: type, answer: "\(answer)", falseAnswers: falseAnswers, sign: sign)

    }
    
}
