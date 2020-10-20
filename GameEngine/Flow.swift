//
//  Flow.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func route(to question: Question, answerCallback: @escaping (Answer) -> Void)
    func route(to result: [Question: Answer])
}

final class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var result: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
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
    
    private func routeNext(from question: Question) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.routeNext(question: question, answer: answer)
        }
    }
    
    private func routeNext(question: Question, answer: Answer) {
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
