//
//  Game.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

@available(*, deprecated)
public class Game<Question, Answer: Equatable, Delegate: QuizDelegate> where Delegate.Question == Question, Delegate.Answer == Answer {
    
    let flow: Flow<Question, Answer, Delegate>
    
    public init(
        questions: [Question],
        delegate: Delegate,
        correctAnswers: [Question: Answer]
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
