//
//  Task.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 05.04.2022.
//

import Foundation

struct Task: Equatable, Codable {
    let id: UUID
    let question: String
    let answer: String
    var currentAnswer: [String]
    
    init(question: String, answer: String) {
        self.id = UUID()
        self.question = question
        self.answer = answer
        
        var tempAnswer = [String]()
        for _ in 0..<answer.count {
            tempAnswer.append("_")
        }
        self.currentAnswer = tempAnswer
    }
    
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var formattedCurentAnswer: String {
        let StringCurrentAnswer = currentAnswer
//        for char in currentAnswer {
//            StringCurrentAnswer.append(String(char))
//        }
        return StringCurrentAnswer.joined(separator: " ")
    }
    
    mutating func updateChar(index: Int, char: String) {
        currentAnswer[index] = char
    }

}

struct TaskManager {
    
    func createEasyTask() -> Task {
        
        let chooseSign = Int.random(in: 0...2)
        
        var number1: Int = 0
        var number2: Int = 0
        var sign: Character = "*"
        var answer: Int = 0
        
        if chooseSign == 0 {
            number1 = Int.random(in: 0...20)
            number2 = Int.random(in: 0...20)
            sign = "+"
            answer = number1 + number2
        } else if chooseSign == 1 {
            number1 = Int.random(in: 20...40)
            number2 = Int.random(in: 0...20)
            sign = "-"
            answer = number1 - number2
        } else if chooseSign == 2 {
            number1 = Int.random(in: 0...10)
            number2 = Int.random(in: 0...10)
            sign = "*"
            answer = number1 * number2
        }
        
        return Task(question: "\(number1) \(sign) \(number2) =", answer: "\(answer)")
    }
}
