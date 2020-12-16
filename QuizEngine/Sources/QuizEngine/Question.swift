//
//  Question.swift
//  QuizEngine
//
//  Created by Abdullah Althobetey on 18/11/2020.
//

import Foundation

public struct Question<T> {
    
    public let value: T
    
    public init(value: T) {
        self.value = value
    }
}
