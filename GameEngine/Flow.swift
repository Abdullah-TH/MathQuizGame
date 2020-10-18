//
//  Flow.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func route(to question: String, answerCallback: @escaping AnswerCallback)
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
            router.route(to: firstQuestion, answerCallback: routeNext(question: firstQuestion))
        }
    }
    
    func routeNext(question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self = self else { return }
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.route(to: nextQuestion, answerCallback: self.routeNext(question: nextQuestion))
            }
        }
    }
}
