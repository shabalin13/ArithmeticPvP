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
