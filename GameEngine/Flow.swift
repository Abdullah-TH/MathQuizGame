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
    func route(to result: [String: String])
}

final class Flow {
    
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.route(to: result)
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            self?.routeNext(question: question, answer: answer)
        }
    }
    
    private func routeNext(question: String, answer: String) {
        result[question] = answer
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.route(to: nextQuestion, answerCallback: routeNext(from: nextQuestion))
            } else {
                router.route(to: result)
            }
        }
    }
}
