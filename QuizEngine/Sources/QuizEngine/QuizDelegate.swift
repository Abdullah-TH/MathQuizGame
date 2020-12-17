//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public protocol QuizDataSource {
    associatedtype Question
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
}

public protocol QuizDelegate {
    associatedtype Question
    associatedtype Answer
    
    func didCompleteQuiz(with answers: [(question: Question, answer: Answer)])
}
