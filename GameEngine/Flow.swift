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
    func route(to result: GameResult<Question, Answer>)
}

struct GameResult<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int 
}

final class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private let scoring: ([Question: Answer]) -> Int
    
    init(
        questions: [Question],
        router: R,
        scoring: @escaping ([Question: Answer]) -> Int
    ) {
        self.router = router
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion, answerCallback: nextAnswerCallback(from: firstQuestion))
        } else {
            router.route(to: gameResult())
        }
    }
    
    private func nextAnswerCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.routeNext(question: question, answer: answer)
        }
    }
    
    private func routeNext(question: Question, answer: Answer) {
        answers[question] = answer
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.route(to: nextQuestion, answerCallback: nextAnswerCallback(from: nextQuestion))
            } else {
                router.route(to: gameResult())
            }
        }
    }
    
    private func gameResult() -> GameResult<Question, Answer> {
        return GameResult(answers: answers, score: scoring(answers))
    }
}
