//
//  iOSViewControllerFactoryTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import XCTest
@testable import MathQuizGame
import QuizEngine
import MathQuizPresentation
@testable import MathQuizUI_iOS

class iOSViewControllerFactoryTests: XCTestCase {
    
    let questionOne = Question(value: "Q1")
    let questionTwo = Question(value: "Q2")
    let answerOne = "A1"
    let answerTwo = "A2"
    
    var questions: [Question<String>] {
        [questionOne, questionTwo]
    }
    
    var options: [Question<String>: [String]] {
        [
            questionOne: [answerOne, answerTwo],
            questionTwo: [answerOne, answerTwo]
        ]
    }
    
    var correctAnswers: [Question<String>: String] {
        [
            questionOne: answerOne,
            questionTwo: answerTwo
        ]
    }
    
    func test_questionViewController_createsQuestionViewControllerWithTitle() {
        let sut = makeSUT(
            questions: questions,
            options: options
        )
        
        let (questionVC, questionPresenter) = makeQuestionViewControllerAndPresenter(
            question: questionOne,
            factory: sut
        )
        
        XCTAssertEqual(questionVC.title, questionPresenter.title)
    }

    func test_questionViewController_createsQuestionViewControllerWithCorrectQuestionAndOptions() {
        let sut = makeSUT(
            questions: questions,
            options: options
        )
        
        let (questionVC, _) = makeQuestionViewControllerAndPresenter(
            question: questionOne,
            factory: sut
        )
        
        XCTAssertEqual(questionVC.question, questionOne.value)
        XCTAssertEqual(questionVC.options, [answerOne, answerTwo])
    }
    
    func test_gameResultViewController_createResultViewControllerWithSummaryAndAnswers() {
        let sut = makeSUT(
            questions: questions,
            options: options,
            correctAnswers: correctAnswers
        )
        
        let (resultVC, resultPresenter) = makeResultViewControllerAndPresenter(
            userAnswers: [questionOne: answerOne, questionTwo: answerOne], // 1 of 2 is correct,
            score: 1,
            factory: sut
        )
        
        XCTAssertEqual(resultVC.summary, resultPresenter.summary)
        XCTAssertEqual(resultVC.answers.count, resultPresenter.presentableAnswers.count)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [Question<String>],
        options: [Question<String> : [String]],
        correctAnswers: [Question<String> : String] = [:]
    ) -> iOSViewControllerFactory {
        
        let sut = iOSViewControllerFactory(
            questions: questions,
            options: options,
            correctAnswers: correctAnswers
        )
        return sut
    }
    
    private func makeQuestionViewControllerAndPresenter(
        question: Question<String>,
        factory: iOSViewControllerFactory
    ) -> (QuestionViewController, QuestionPresenter) {
        
        let presenter = QuestionPresenter(
            questions: questions,
            question: questionOne
        )
        
        let questionVC = factory.questionViewController(
            for: question,
            answerCallback: { _ in }
        ) as! QuestionViewController
        
        return (questionVC, presenter)
    }
    
    private func makeResultViewControllerAndPresenter(
        userAnswers: [Question<String>: String],
        score: Int,
        factory: iOSViewControllerFactory
    ) -> (GameResultViewController, GameResultPresenter) {
        
        let gameResult = GameResult(answers: userAnswers, score: score)
        let presenter = GameResultPresenter(
            questions: questions,
            gameResult: gameResult,
            correctAnswers: correctAnswers
        )
        let resultVC = factory.gameResultViewController(for: gameResult) as! GameResultViewController
        return (resultVC, presenter)
    }
    
}
