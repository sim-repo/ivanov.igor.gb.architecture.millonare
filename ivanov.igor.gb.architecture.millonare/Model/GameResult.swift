//
//  GameResult.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class GameResult: Codable{
    
    var questionsPassedAmount: Int = 0
    var questionsFullAmount: Int = 0
    
    
    init(questionsPassedAmount: Int, questionsFullAmount: Int) {
        self.questionsPassedAmount = questionsPassedAmount
        self.questionsFullAmount = questionsFullAmount
    }
    
    
    //MARK:- Codable >>
    enum CodingKeys: String, CodingKey {
        case questionsPassedAmount
        case questionsFullAmount
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(questionsPassedAmount, forKey: .questionsPassedAmount)
        try container.encode(questionsFullAmount, forKey: .questionsFullAmount)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        questionsPassedAmount = try container.decode(Int.self, forKey: .questionsPassedAmount)
        questionsFullAmount = try container.decode(Int.self, forKey: .questionsFullAmount)
    }
}
