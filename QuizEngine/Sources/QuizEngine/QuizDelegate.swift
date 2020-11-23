//
//  QuizDelegate.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: GameResult<Question, Answer>)
}

