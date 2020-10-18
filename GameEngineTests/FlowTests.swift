//
//  FlowTests.swift
//  GameEngineTests
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import XCTest
@testable import GameEngine

class FlowTests: XCTestCase {

    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestions() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        let sut = makeSUT(questions: ["Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routeToFirstQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestionsTwice_routeToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestions() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routeToResult() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertEqual(router.routedResult!, [:])
    }
    
    func test_startAndAnswerFirstAndSecondQuestions_withTwoQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult!, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }

    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var routedResult: [String: String]?
        var answerCallback: Router.AnswerCallback = { _ in }
        
        func route(to question: String, answerCallback: @escaping Router.AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func route(to result: [String : String]) {
            routedResult = result
        }
    }
}
