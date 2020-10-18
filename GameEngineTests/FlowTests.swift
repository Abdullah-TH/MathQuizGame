//
//  FlowTests.swift
//  GameEngineTests
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import XCTest
@testable import GameEngine

class FlowTests: XCTestCase {

    func test_start_withNoQuestions_doesNotRouteToQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routeToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, "Q2")
    }

    class RouterSpy: Router {
        
        var routedQuestionCount = 0
        var routedQuestion: String? = nil
        
        func route(to question: String) {
            routedQuestionCount += 1
            routedQuestion = question
        }
    }
}
