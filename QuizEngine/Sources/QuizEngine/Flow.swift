//
//  Flow.swift
//  QuizEngine
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
        delegateQuestionHandling(at: questions.startIndex)
    }
    
    private func delegateQuestionHandling(at index: Int) {
        if index < questions.endIndex {
            let question = questions[index]
            delegate.handle(question: question, answerCallback: callback(for: question, at: index))
        } else {
            delegate.handle(result: gameResult())
        }
    }
    
    private func delegateQuestionHandling(after index: Int) {
        delegateQuestionHandling(at: questions.index(after: index))
    }
    
    private func callback(for question: Question, at index: Int) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.answers[question] = answer
            self?.delegateQuestionHandling(after: index)
        }
    }
    
    private func gameResult() -> GameResult<Question, Answer> {
        return GameResult(answers: answers, score: scoring(answers))
    }
}
