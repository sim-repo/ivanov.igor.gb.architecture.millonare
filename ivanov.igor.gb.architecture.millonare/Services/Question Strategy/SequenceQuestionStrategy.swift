//
//  SequenceQuestionStrategy.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

// #strategy
final class SequenceQuestionStrategy: QuestionStrategyProtocol {
    
    func getNewQuestionModel(allQuestionModels: [QuestionModel], usedQuestionModels: [QuestionModel]?) -> QuestionModel? {
        var idx = -1
        if let usedQuestionModels = usedQuestionModels {
            idx = usedQuestionModels.count - 1
        }
        if idx + 1 <= allQuestionModels.count - 1 {
            return allQuestionModels[idx + 1]
        }
        return nil
    }
}
