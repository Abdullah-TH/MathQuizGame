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
        let (_, spy) = makeSUT(questions: ["Q1"])
        
        XCTAssertTrue(spy.questionsAsked.isEmpty)
        XCTAssertTrue(spy.completedQuizzes.isEmpty)
    }
    
    func test_start_withNoQuestions_doesNotAsksQuestionsButCompleteWithEmptyQuiz() {
        let (quiz, spy) = makeSUT(questions: [])
        
        quiz.start()
        
        XCTAssertTrue(spy.questionsAsked.isEmpty)
        XCTAssertTrue(spy.completedQuizzes.count == 1) // there is one completed quiz
        XCTAssertTrue(spy.completedQuizzes[0].isEmpty) // and that quiz is empty
    }
    
    func test_startAndAnswerFirstAndSecondQuestions_withTwoQuestions_askForTwoQuestionsAndCompleteQuiz() {
        let (quiz, spy) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        spy.answerCompletions[0]("A1")
        spy.answerCompletions[1]("A2")
        
        XCTAssertEqual(spy.questionsAsked, ["Q1", "Q2"])
        XCTAssertEqual(spy.completedQuizzes.count, 1)
        assertEqual(spy.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_askForAllQuestionsButDoesNotCompleteQuiz() {
        let (quiz, spy) = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        quiz.start()
        spy.answerCompletions[0]("A1")
        spy.answerCompletions[1]("A2")
        
        XCTAssertEqual(spy.questionsAsked, ["Q1", "Q2", "Q3"])
        XCTAssertTrue(spy.completedQuizzes.isEmpty)
    }
    
    func test_startAndAnswerAllQuestionsTwice_completeTwice() {
        let (quiz, spy) = makeSUT(questions: ["Q1", "Q2"])
        
        quiz.start()
        spy.answerCompletions[0]("A1")
        spy.answerCompletions[1]("A2")
        spy.answerCompletions[0]("A3")
        spy.answerCompletions[1]("A4")
        
        XCTAssertTrue(spy.completedQuizzes.count == 2)
    }
    
    func test_startAndAnswerAllQuestionsManyTimes_quizCompleteWheneverAnsweringTheLastQuestion() {
        let (quiz, spy) = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        quiz.start()
        spy.answerCompletions[0]("A1")
        spy.answerCompletions[1]("A2")
        spy.answerCompletions[2]("A3")   // 1
        spy.answerCompletions[2]("A3-2") // 2
        spy.answerCompletions[2]("A3-3") // 3
        spy.answerCompletions[2]("A3-4") // 4
        
        XCTAssertTrue(spy.completedQuizzes.count == 4)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [String],
        correctAnswers: [String: String] = [:]
    ) -> (Quiz<QuizSpy, QuizSpy>, QuizSpy) {
        
        let spy = QuizSpy()
        let quiz = Quiz(questions: questions, dataSource: spy, delegate: spy)
        return (quiz, spy)
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
