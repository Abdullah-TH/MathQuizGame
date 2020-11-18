//
//  GameResultPresenterTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 04/11/2020.
//

import XCTest
@testable import MathQuizGame
import GameEngine

class GameResultPresenterTests: XCTestCase {
    
    let questionOne = Question(value: "Q1")
    let questionTwo = Question(value: "Q2")
    let questionThree = Question(value: "Q3")
    
    let answerOne = "A1"
    let answerTwo = "A2"
    let answerThree = "A3"
    let wrongAnswer = "A99"

    func test_summary_withTwoQuestionsAndScoreOne_returnCorrectSummary() {
        let sut = makeSUT(
            questions: [],
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
            questions: [],
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
            questions: [],
            userAnswers: [:],
            score: 0
        )
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withTwoQuestions_presentableAnswersMappedCorrectlyAndInOrder() {
        let orderedQuestions = [questionOne, questionTwo, questionThree]
        let sut = makeSUT(
            questions: orderedQuestions,
            userAnswers: [
                questionTwo: answerTwo,
                questionThree: wrongAnswer,
                questionOne: answerOne
            ],
            correctAnswers: [
                questionThree: answerThree,
                questionTwo: answerTwo,
                questionOne: answerOne
            ],
            score: 0
        )
        
        XCTAssertEqual(sut.presentableAnswers.count, 3)
        
        XCTAssertEqual(sut.presentableAnswers.first?.question, questionOne.value)
        XCTAssertEqual(sut.presentableAnswers.first?.answer, answerOne)
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswers[1].question, questionTwo.value)
        XCTAssertEqual(sut.presentableAnswers[1].answer, answerTwo)
        XCTAssertNil(sut.presentableAnswers[1].wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.last?.question, questionThree.value)
        XCTAssertEqual(sut.presentableAnswers.last?.answer, answerThree)
        XCTAssertNotNil(sut.presentableAnswers.last?.wrongAnswer)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [Question<String>],
        userAnswers: [Question<String>: String],
        correctAnswers: [Question<String>: String] = [:],
        score: Int
    ) -> GameResultPresenter {
        
        let gameResult = GameResult(answers: userAnswers, score: score)
        return GameResultPresenter(
            questions: questions,
            gameResult: gameResult,
            correctAnswers: correctAnswers
        )
    }

}
