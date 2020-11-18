//
//  iOSViewControllerFactoryTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import XCTest
@testable import MathQuizGame
import GameEngine

class iOSViewControllerFactoryTests: XCTestCase {
    
    let questionOne = Question(value: "Q1")
    let questionTwo = Question(value: "Q2")
    let answerOne = "A1"
    let answerTwo = "A2"
    
    func test_questionViewController_createsQuestionViewControllerWithTitle() {
        let questionPresenter = QuestionPresenter(
            questions: [questionOne],
            question: questionOne
        )
        let (_, questionVC) = makeSUT(
            questions: [questionOne],
            question: questionOne,
            options: [answerOne, answerTwo]
        )
        
        XCTAssertEqual(questionVC.title, questionPresenter.title)
    }

    func test_questionViewController_createsQuestionViewControllerWithCorrectQuestionAndOptions() {
        let (_, questionVC) = makeSUT(
            questions: [questionOne],
            question: questionOne,
            options: [answerOne, answerTwo]
        )
        
        XCTAssertEqual(questionVC.question, questionOne.value)
        XCTAssertEqual(questionVC.options, [answerOne, answerTwo])
    }
    
    func test_gameResultViewController_createResultsViewControllerWithSummary() {
        let questions = [questionOne, questionTwo]
        let factory = iOSViewControllerFactory(
            questions: questions,
            options: [
                questionOne: [answerOne, answerTwo],
                questionTwo: [answerOne, answerTwo]
            ],
            correctAnswers: [
                questionOne: answerOne,
                questionTwo: answerTwo
            ]
        )
        let userAnswers = [questionOne: answerOne, questionTwo: answerOne] // 1 of 2 is correct
        let gameResults = GameResult(answers: userAnswers, score: 1)
        let resultVC = factory.gameResultViewController(for: gameResults) as! GameResultsViewController
        let resultPresenter = GameResultPresenter(
            questions: questions,
            gameResult: gameResults,
            correctAnswers: [questionOne: answerOne, questionTwo: answerTwo]
        )
        
        XCTAssertEqual(resultVC.summary, resultPresenter.summary)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [Question<String>],
        question: Question<String>,
        options: [String],
        correctAnswers: [Question<String> : String] = [:]
    ) -> (iOSViewControllerFactory, QuestionViewController) {
        
        let sut = iOSViewControllerFactory(
            questions: questions,
            options: [questionOne: options],
            correctAnswers: correctAnswers
        )
        let questionVC = sut.questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
        return (sut, questionVC)
    }
    
}
