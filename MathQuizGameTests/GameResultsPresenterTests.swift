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
    
    let questionOne = Question(value: "Q1")
    let questionTwo = Question(value: "Q2")
    let questionThree = Question(value: "Q3")
    
    let answerOne = "A1"
    let answerTwo = "A2"
    let answerThree = "A3"
    let wrongAnswer = "A99"

    func test_summary_withTwoQuestionsAndScoreOne_returnCorrectSummary() {
        let sut = makeSUT(
            userAnswers: [
                questionOne: answerOne,
                questionTwo: wrongAnswer
            ],
            score: 1
        )
        
        XCTAssertEqual(sut.summary, "You got 1 of 2 correct answers")
    }
    
    func test_summary_withThreeQuestionsAndScoreTwo_returnCorrectSummary() {
        let sut = makeSUT(
            userAnswers: [
                questionOne: answerOne,
                questionTwo: answerTwo,
                questionThree: wrongAnswer
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
            userAnswers: [questionOne: answerOne],
            correctAnswers: [questionOne: answerOne],
            score: 1
        )
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, questionOne.value)
        XCTAssertEqual(sut.presentableAnswers.first?.answer, answerOne)
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }
    
    func test_presentableAnswers_withGameResultOneWrongAnswer_presentableAnswersMappedCorrectly() {
        let sut = makeSUT(
            userAnswers: [questionThree: wrongAnswer],
            correctAnswers: [questionThree: answerThree],
            score: 0
        )
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, questionThree.value)
        XCTAssertEqual(sut.presentableAnswers.first?.answer, answerThree)
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, wrongAnswer)
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
