//
//  GameTests.swift
//  GameEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import XCTest
import QuizEngine

@available(*, deprecated)
class DeprecatedGameTests: XCTestCase {
    
    func test_gameStart_withNoQuestions_doesNotRouteToQuestions() {
        let (game, router) = makeSUT(questions: [])
        
        game.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_game_withQuestionsButNotStarted_doesNotRouteToQuestionsOrResult() {
        let (_, router) = makeSUT(questions: ["Q1"])
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
        XCTAssertNil(router.routedResult)
    }
    
    func test_gameStart_withOneQuestion_routeToCorrectQuestion() {
        let (game, router) = makeSUT(questions: ["Q1"])
        
        game.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_gameStart_withOneQuestion_routeToCorrectQuestion_2() {
        let (game, router) = makeSUT(questions: ["Q2"])
        
        game.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_gameStart_withTwoQuestions_routeToFirstQuestion() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_gameStart_withTwoQuestionsTwice_routeToFirstQuestionTwice() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        game.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_gameStartAndAnswerFirstAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestions() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        game.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_gameStartAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let (game, router) = makeSUT(questions: ["Q1"])
        
        game.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_gameStart_withNoQuestions_routeToResult() {
        let (game, router) = makeSUT(questions: [])
        
        game.start()
        
        XCTAssertEqual(router.routedResult!.answers, [:])
    }
    
    func test_gameStartWithNoAnswer_withOneQuestions_doesNotRouteToResult() {
        let (game, router) = makeSUT(questions: ["Q1"])
        
        game.start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_gameStartAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        router.answerCallback("A1")
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_gameStartAndAnswerFirstAndSecondQuestions_withTwoQuestions_routeToResult() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"])
        
        game.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }

    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        game.start()
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }

    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        game.start()
        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult!.score, 1)
    }

    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        let (game, router) = makeSUT(questions: ["Q1", "Q2"], correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        game.start()
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [String],
        correctAnswers: [String: String] = [:]
    ) -> (Game<String, String, RouterSpy>, RouterSpy) {
        
        let router = RouterSpy()
        let game = Game(
            questions: questions,
            router: router,
            correctAnswers: correctAnswers
        )
        return (game, router)
    }

}
