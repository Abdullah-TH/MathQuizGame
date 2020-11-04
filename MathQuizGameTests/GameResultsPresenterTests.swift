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
        let answers = [
            Question(value: "Q1"): "A1",
            Question(value: "Q2"): "wrong"
        ]
        
        let gameResult = GameResult(answers: answers, score: 1)
        let sut = GameResultPresenter(gameResult: gameResult, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1 of 2 correct answers")
    }
    
    func test_summary_withThreeQuestionsAndScoreTwo_returnCorrectSummary() {
        let answers = [
            Question(value: "Q1"): "A1",
            Question(value: "Q2"): "A2",
            Question(value: "Q3"): "wrong"
        ]
        let gameResult = GameResult(answers: answers, score: 2)
        let sut = GameResultPresenter(gameResult: gameResult, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 2 of 3 correct answers")
    }
    
    func test_presentableAnswers_withGameResultEmpty_presentableAnswersShouldBeEmpty() {
        let answers = [Question<String>: String]()
        let gameResult = GameResult(answers: answers, score: 0)
        let sut = GameResultPresenter(gameResult: gameResult, correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withGameResultOneCorrectAnswer_presentableAnswersMappedCorrectly() {
        let answers = [Question(value: "Q1"): "A1"]
        let correctAnswers = [Question(value: "Q1"): "A1"]
        let gameResult = GameResult(answers: answers, score: 1)
        let sut = GameResultPresenter(gameResult: gameResult, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }
    
    func test_presentableAnswers_withGameResultOneWrongAnswer_presentableAnswersMappedCorrectly() {
        let answers = [Question(value: "Q3"): "A9"]
        let correctAnswers = [Question(value: "Q3"): "A3"]
        let gameResult = GameResult(answers: answers, score: 1)
        let sut = GameResultPresenter(gameResult: gameResult, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q3")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A9")
    }

}
