//
//  ScoreTests.swift
//  
//
//  Created by Abdullah Althobetey on 17/12/2020.
//

import Foundation
import XCTest

class ScoreTests: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        let score = BasicScore.score(for: [], comparingTo: [])
        XCTAssertEqual(score, 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        let score = BasicScore.score(for: ["wrong"], comparingTo: ["correct"])
        XCTAssertEqual(score, 0)
    }
    
    func test_oneCorrectAnswer_scoresOne() {
        let score = BasicScore.score(for: ["correct"], comparingTo: ["correct"])
        XCTAssertEqual(score, 1)
    }
    
    func test_oneCorrectOneWrongAnswers_scoresOne() {
        let score = BasicScore.score(for: ["correct 1", "wrong"], comparingTo: ["correct 1", "correct 2"])
        XCTAssertEqual(score, 1)
    }
    
    func test_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["correct 1", "correct 2"], comparingTo: ["correct 1", "correct 2"])
        XCTAssertEqual(score, 2)
    }
    
    func test_withUnequalSizedDataWithTwoManyAnswers_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["correct 1", "correct 2", "extra answer"], comparingTo: ["correct 1", "correct 2"])
        XCTAssertEqual(score, 2)
    }
    
    func test_withUnequalSizedDataWithTwoManyCorrectAnswers_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["correct 1", "correct 2"], comparingTo: ["correct 1", "correct 2", "correct 3"])
        XCTAssertEqual(score, 2)
    }
}
