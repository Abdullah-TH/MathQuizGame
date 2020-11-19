//
//  PresentableAnswer.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 20/10/2020.
//

import Foundation

public struct PresentableAnswer {
    
    public let question: String
    public let answer: String
    public let wrongAnswer: String?
    
    public init(question: String, answer: String, wrongAnswer: String?) {
        self.question = question
        self.answer = answer
        self.wrongAnswer = wrongAnswer
    }
}
