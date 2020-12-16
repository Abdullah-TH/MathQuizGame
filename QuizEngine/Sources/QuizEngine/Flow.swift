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
    private var answers: [(Question, Answer)] = []
    
    init(
        questions: [Question],
        delegate: Delegate
    ) {
        self.delegate = delegate
        self.questions = questions
    }
    
    func start() {
        delegateQuestionHandling(at: questions.startIndex)
    }
    
    private func delegateQuestionHandling(at index: Int) {
        if index < questions.endIndex {
            let question = questions[index]
            delegate.answer(for: question, completion: answer(for: question, at: index))
        } else {
            delegate.didCompleteQuiz(with: answers)
        }
    }
    
    private func answer(for question: Question, at index: Int) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.answers.append((question, answer))
            self?.delegateQuestionHandling(after: index)
        }
    }
    
    private func delegateQuestionHandling(after index: Int) {
        delegateQuestionHandling(at: questions.index(after: index))
    }
}
