//
//  Flow.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import Foundation

protocol Router {
    func route(to question: String, answerCallback: @escaping (String) -> Void)
}

final class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion) { [weak self] _ in
                guard let self = self else { return }
                if let firstQuestionIndex = self.questions.firstIndex(of: firstQuestion) {
                    let nextQuestion = self.questions[firstQuestionIndex + 1]
                    self.router.route(to: nextQuestion) { _ in }
                }
            }
        }
    }
}
