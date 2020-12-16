//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(with answers: [(question: Question, answer: Answer)])
    
    @available(*, deprecated, message: "use didCompleteQuiz(with:_) instead")
    func handle(result: GameResult<Question, Answer>)
}

#warning("Remove this when migrating to the new method")
public extension QuizDelegate {
    func didCompleteQuiz(with answers: [(question: Question, answer: Answer)]) {}
}
