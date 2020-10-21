//
//  GameResult.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation

struct GameResult<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
