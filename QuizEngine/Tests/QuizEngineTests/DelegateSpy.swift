//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation
import QuizEngine

class QuizSpy: QuizDataSource, QuizDelegate {
    
    var questionsAsked: [String] = []
    var completedQuizzes: [[(String, String)]] = []
    var answerCompletions: [(String) -> Void] = []
    
    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionsAsked.append(question)
        self.answerCompletions.append(completion)
    }
    
    func didCompleteQuiz(with answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}
