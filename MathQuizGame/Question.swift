//
//  Question.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import Foundation

struct Question<T: Hashable>: Hashable {
    let value: T
}
