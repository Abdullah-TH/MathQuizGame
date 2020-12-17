//
//  Quiz.swift
//  QuizEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public class Quiz<Delegate: QuizDelegate, DataSource: QuizDataSource>
where Delegate.Answer: Equatable,
      Delegate.Answer == DataSource.Answer,
      Delegate.Question == DataSource.Question
{
    let flow: Flow<Delegate.Question, Delegate.Answer, Delegate, DataSource>
    
    public init(
        questions: [Delegate.Question],
        dataSource: DataSource,
        delegate: Delegate
    ) {
        flow = Flow(questions: questions, dataSource: dataSource, delegate: delegate)
    }
    
    public func start() {
        flow.start()
    }
}
