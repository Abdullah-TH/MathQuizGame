//
//  GameResult.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

public struct GameResult<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
