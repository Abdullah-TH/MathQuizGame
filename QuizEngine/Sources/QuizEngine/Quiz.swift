//
//  Quiz.swift
//  QuizEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public class Quiz<Delegate: QuizDelegate> where Delegate.Answer: Equatable {
    
    let flow: Flow<Delegate.Question, Delegate.Answer, Delegate>
    
    public init(
        questions: [Delegate.Question],
        delegate: Delegate,
        correctAnswers: [Delegate.Question: Delegate.Answer]
    ) {
        flow = Flow(questions: questions, delegate: delegate, scoring: { answers in
            scoring(answers: answers, correctAnswers: correctAnswers)
        })
    }
    
    public func start() {
        flow.start()
    }
}

private func scoring<Question, Answer: Equatable>(
    answers: [Question: Answer],
    correctAnswers: [Question: Answer]
) -> Int {
    
    var score = 0
    for (question, answer) in answers {
        if answer == correctAnswers[question] {
            score += 1
        }
    }
    
    return score
}
