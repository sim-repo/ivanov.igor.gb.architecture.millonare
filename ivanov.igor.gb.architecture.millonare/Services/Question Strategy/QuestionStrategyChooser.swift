//
//  QuestionStrategyChooser.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

// #strategy
final class QuestionStrategyChooser {
    private var questionStrategyProtocol: QuestionStrategyProtocol?
    
    init(strategy: QuestionSequenceEnum) {
        switch strategy {
        case .random:
            questionStrategyProtocol = RandomQuestionStrategy()
        case .sequence:
            questionStrategyProtocol = SequenceQuestionStrategy()
        }
    }
    
    public func getNewQuestionModel(allQuestionModels: [QuestionModel], usedQuestionModels: [QuestionModel]?) -> QuestionModel? {
        questionStrategyProtocol?.getNewQuestionModel(allQuestionModels: allQuestionModels, usedQuestionModels: usedQuestionModels)
    }
}
