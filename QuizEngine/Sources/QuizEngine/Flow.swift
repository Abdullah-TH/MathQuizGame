//
//  Flow.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import Foundation

final class Flow<Question, Answer, Delegate: QuizDelegate> where Delegate.Question == Question, Delegate.Answer == Answer {
    
    private let delegate: Delegate
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private let scoring: ([Question: Answer]) -> Int
    
    init(
        questions: [Question],
        delegate: Delegate,
        scoring: @escaping ([Question: Answer]) -> Int
    ) {
        self.delegate = delegate
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            delegate.handle(question: firstQuestion, answerCallback: nextAnswerCallback(from: firstQuestion))
        } else {
            delegate.handle(result: gameResult())
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
                delegate.handle(question: nextQuestion, answerCallback: nextAnswerCallback(from: nextQuestion))
            } else {
                delegate.handle(result: gameResult())
            }
        }
    }
    
    private func gameResult() -> GameResult<Question, Answer> {
        return GameResult(answers: answers, score: scoring(answers))
    }
}
