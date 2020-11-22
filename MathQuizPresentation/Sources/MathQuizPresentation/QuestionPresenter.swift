//
//  QuestionPresenter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 08/11/2020.
//

import Foundation
import QuizEngine

public struct QuestionPresenter {
    
    private let questions: [Question<String>]
    private let question: Question<String>
    
    public init(questions: [Question<String>], question: Question<String>) {
        self.questions = questions
        self.question = question
    }
    
    public var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
        return "Question \(index + 1)"
    }
}
