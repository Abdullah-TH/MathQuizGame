//
//  Router.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func route(to question: Question, answerCallback: @escaping (Answer) -> Void)
    func route(to result: GameResult<Question, Answer>)
}
