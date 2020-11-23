//
//  GameTests.swift
//  GameEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import XCTest
import QuizEngine


class GameTests: XCTestCase {
    
    func test_gameStart_withNoQuestions_doesNotDelegateQuestionsHandling() {
        let (game, delegate) = makeSUT(questions: [])
        
        game.start()
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
    }
    
    func test_game_withQuestionsButNotStarted_doesNotDelegateQuestionsOrResultHandling() {
        let (_, delegate) = makeSUT(questions: ["Q1"])
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_gameStart_withOneQuestion_delegatesQuestionForHandling() {
        let (game, delegate) = makeSUT(questions: ["Q1"])
        
        game.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_gameStart_withOneQuestion_delegatesAnotherQuestionForHandling() {
        let (game, delegate) = makeSUT(questions: ["Q2"])
        
        game.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q2"])
    }
    
    func test_gameStart_withTwoQuestions_delegatesFirstQuestionHandling() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_gameStart_withTwoQuestionsTwice_delegatesFirstQuestionHandlingTwice() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        game.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q1"])
    }
    
    func test_gameStartAndAnswerFirstAndSecondQuestion_withThreeQuestions_delegatesAllQuestionsForHandling() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        game.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_gameStartAndAnswerFirstQuestion_withOneQuestions_doesDelegatesMoreQuestions() {
        let (game, delegate) = makeSUT(questions: ["Q1"])
        
        game.start()
        delegate.answerCallback("A1")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_gameStart_withNoQuestions_delegatesResultHandling() {
        let (game, delegate) = makeSUT(questions: [])
        
        game.start()
        
        XCTAssertEqual(delegate.handledResult!.answers, [:])
    }
    
    func test_gameStartWithNoAnswer_withOneQuestions_doesNotDelegatesResultHandling() {
        let (game, delegate) = makeSUT(questions: ["Q1"])
        
        game.start()
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_gameStartAndAnswerFirstQuestion_withTwoQuestions_doesNotDelegatesResultHandling() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        delegate.answerCallback("A1")
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_gameStartAndAnswerFirstAndSecondQuestions_withTwoQuestions_delegatesResultHandling() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }

    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        game.start()
        delegate.answerCallback("wrong")
        delegate.answerCallback("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score, 0)
    }

    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        game.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("wrong")

        XCTAssertEqual(delegate.handledResult!.score, 1)
    }

    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        let (game, delegate) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        game.start()
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
        let game = Quiz(
            questions: questions,
            delegate: delegate,
            correctAnswers: correctAnswers
        )
        return (game, delegate)
    }

}
