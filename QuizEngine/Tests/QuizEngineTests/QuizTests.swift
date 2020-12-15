//
//  QuizTests.swift
//  QuizEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import XCTest
import QuizEngine


class QuizTests: XCTestCase {
    
    func test_start_withNoQuestions_doesNotDelegateQuestionsHandling() {
        let (quiz, delegate) = makeSUT(questions: [])
        
        quiz.start()
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
    }
    
    func test_quiz_withQuestionsButNotStarted_doesNotDelegateQuestionsOrResultHandling() {
        let (_, delegate) = makeSUT(questions: ["Q1"])
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_start_withOneQuestion_delegatesQuestionForHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q1"])
        
        quiz.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_delegatesAnotherQuestionForHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q2"])
        
        quiz.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegatesFirstQuestionHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestionsTwice_delegatesFirstQuestionHandlingTwice() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        quiz.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_delegatesAllQuestionsForHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        quiz.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesDelegatesMoreQuestions() {
        let (quiz, delegate) = makeSUT(questions: ["Q1"])
        
        quiz.start()
        delegate.answerCallback("A1")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_delegatesResultHandling() {
        let (quiz, delegate) = makeSUT(questions: [])
        
        quiz.start()
        
        XCTAssertEqual(delegate.handledResult!.answers, [:])
    }
    
    func test_startWithNoAnswer_withOneQuestions_doesNotDelegatesResultHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q1"])
        
        quiz.start()
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotDelegatesResultHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        delegate.answerCallback("A1")
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestions_withTwoQuestions_delegatesResultHandling() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }

    func test_start_answerZeroOutOfTwoCorrectly_scoresZero() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        quiz.start()
        delegate.answerCallback("wrong")
        delegate.answerCallback("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score, 0)
    }

    func test_start_answerOneOutOfTwoCorrectly_scoresOne() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        quiz.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("wrong")

        XCTAssertEqual(delegate.handledResult!.score, 1)
    }

    func test_start_answerTwoOutOfTwoCorrectly_scoresTwo() {
        let (quiz, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        quiz.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

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

}
