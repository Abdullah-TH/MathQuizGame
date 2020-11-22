//
//  Answer.swift
//  MathQuizUI_iOS
//
//  Created by Abdullah Althobetey on 19/11/2020.
//

import Foundation

public struct Answer {
    
    public let question: String
    public let answer: String
    public let wrongAnswer: String?
    
    public init(question: String, answer: String, wrongAnswer: String?) {
        self.question = question
        self.answer = answer
        self.wrongAnswer = wrongAnswer
    }
}
