//
//  RouterSpy.swift
//  GameEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation
import GameEngine

class RouterSpy: Router {
    
    var routedQuestions: [String] = []
    var routedResult: GameResult<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }
    
    func route(to question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func route(to result: GameResult<String, String>) {
        routedResult = result
    }
}
