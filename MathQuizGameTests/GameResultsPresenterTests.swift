//
//  GameResultsPresenterTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 04/11/2020.
//

import XCTest
@testable import MathQuizGame
import GameEngine

class GameResultsPresenterTests: XCTestCase {

    func test_summary_withTwoQuestionsAndScoreOne_returnCorrectSummary() {
        let sut = makeSUT(
            userAnswers: [
                Question(value: "Q1"): "A1",
                Question(value: "Q2"): "wrong"
            ],
            score: 1
        )
        
        XCTAssertEqual(sut.summary, "You got 1 of 2 correct answers")
    }
    
    func test_summary_withThreeQuestionsAndScoreTwo_returnCorrectSummary() {
        let sut = makeSUT(
            userAnswers: [
                Question(value: "Q1"): "A1",
                Question(value: "Q2"): "A2",
                Question(value: "Q3"): "wrong"
            ],
            score: 2
        )
        
        XCTAssertEqual(sut.summary, "You got 2 of 3 correct answers")
    }
    
    func test_presentableAnswers_withGameResultEmpty_presentableAnswersShouldBeEmpty() {
        let sut = makeSUT(
            userAnswers: [:],
            score: 0
        )
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withGameResultOneCorrectAnswer_presentableAnswersMappedCorrectly() {
        let sut = makeSUT(
            userAnswers: [Question(value: "Q1"): "A1"],
            correctAnswers: [Question(value: "Q1"): "A1"],
            score: 1
        )
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }
    
    func test_presentableAnswers_withGameResultOneWrongAnswer_presentableAnswersMappedCorrectly() {
        let sut = makeSUT(
            userAnswers: [Question(value: "Q3"): "A9"],
            correctAnswers: [Question(value: "Q3"): "A3"],
            score: 0
        )
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q3")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A9")
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(
        userAnswers: [Question<String>: String],
        correctAnswers: [Question<String>: String] = [:],
        score: Int
    ) -> GameResultPresenter {
        
        let gameResult = GameResult(answers: userAnswers, score: score)
        return GameResultPresenter(gameResult: gameResult, correctAnswers: correctAnswers)
    }

}
