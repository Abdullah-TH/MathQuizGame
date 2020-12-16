//
//  Quiz.swift
//  QuizEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public class Quiz<Delegate: QuizDelegate> where Delegate.Answer: Equatable {
    
    let flow: Flow<Delegate.Question, Delegate.Answer, Delegate>
    
    public init(questions: [Delegate.Question], delegate: Delegate) {
        flow = Flow(questions: questions, delegate: delegate)
    }
    
    public func start() {
        flow.start()
    }
}
