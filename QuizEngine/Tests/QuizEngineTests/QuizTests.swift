//
//  QuizTests.swift
//  QuizEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import XCTest
import QuizEngine


class QuizTests: XCTestCase {
    
    func test_quiz_withQuestionsButNotStarted_doesNotAsksQuestionsNorCompleteQuiz() {
        let (_, delegate) = makeSUT(questions: ["Q1"])
        
        XCTAssertTrue(delegate.questionsAsked.isEmpty)
        XCTAssertTrue(delegate.completedQuizzes.isEmpty)
    }
    
    func test_start_withNoQuestions_doesNotAsksQuestionsButCompleteWithEmptyQuiz() {
        let (quiz, delegate) = makeSUT(questions: [])
        
        quiz.start()
        
        XCTAssertTrue(delegate.questionsAsked.isEmpty)
        XCTAssertTrue(delegate.completedQuizzes.count == 1) // there is one completed quiz
        XCTAssertTrue(delegate.completedQuizzes[0].isEmpty) // and that quiz is empty
    }
    
    func test_startAndAnswerFirstAndSecondQuestions_withTwoQuestions_askForTwoQuestionsAndCompleteQuiz() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.questionsAsked, ["Q1", "Q2"])
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_askForAllQuestionsButDoesNotCompleteQuiz() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        quiz.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.questionsAsked, ["Q1", "Q2", "Q3"])
        XCTAssertTrue(delegate.completedQuizzes.isEmpty)
    }

    func test_start_answerZeroOutOfTwoCorrectly_scoresZero() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        quiz.start()
        delegate.answerCompletion("wrong")
        delegate.answerCompletion("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score, 0)
    }

    func test_start_answerOneOutOfTwoCorrectly_scoresOne() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        quiz.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("wrong")

        XCTAssertEqual(delegate.handledResult!.score, 1)
    }

    func test_start_answerTwoOutOfTwoCorrectly_scoresTwo() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        quiz.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")

        XCTAssertEqual(delegate.handledResult!.score, 2)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [String],
        correctAnswers: [String: String] = [:]
    ) -> (Quiz<DelegateSpy>, DelegateSpy) {
        
        let delegate = DelegateSpy()
        let quiz = Quiz(
            questions: questions,
            delegate: delegate,
            correctAnswers: correctAnswers
        )
        return (quiz, delegate)
    }
    
    private func assertEqual(
        _ a1: [(String, String)],
        _ a2: [(String, String)],
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            a1.elementsEqual(a2, by: ==),
            "\(a1) is not equal to \(a2)",
            file: file,
            line: line
        )
    }

}
