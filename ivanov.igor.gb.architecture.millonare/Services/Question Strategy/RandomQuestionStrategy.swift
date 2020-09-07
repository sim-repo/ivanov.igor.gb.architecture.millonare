//
//  RandomQuestionStrategy.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

// #strategy
final class RandomQuestionStrategy: QuestionStrategyProtocol {
    
    func getNewQuestionModel(allQuestionModels: [QuestionModel], usedQuestionModels: [QuestionModel]?) -> QuestionModel? {
        let all = Set<QuestionModel>(allQuestionModels)
        let used = Set<QuestionModel>(usedQuestionModels ?? [])
        let diff = all.subtracting(used)
        
        guard diff.count > 0 else { return nil }
        
        let idx = Int.random(in: 0..<diff.count)
        return allQuestionModels[idx]
    }
}
