//
//  BasicScore.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 17/12/2020.
//

import Foundation

public class BasicScore {
    
    public static func score(
        for answers: [String],
        comparingTo correctAnswers: [String]
    ) -> Int {
        var score = 0
        for (index, answer) in answers.enumerated() {
            guard index < correctAnswers.count else { return score }
            let isCorrect = answer == correctAnswers[index]
            score += isCorrect ? 1 : 0
        }
        return score
    }
}
