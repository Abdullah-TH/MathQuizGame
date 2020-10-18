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
    
    func test_startAndAnswer_withTwoQuestions_routeToSecondQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }

    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var answerCallback: (String) -> Void = { _ in }
        
        func route(to question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
