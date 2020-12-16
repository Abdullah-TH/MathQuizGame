//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation
import QuizEngine

class DelegateSpy: QuizDelegate {
    
    var questionsAsked: [String] = []
    var completedQuizzes: [[(String, String)]] = []
    var answerCompletion: (String) -> Void = { _ in }
    
    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionsAsked.append(question)
        self.answerCompletion = completion
    }
    
    func didCompleteQuiz(with answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}
