//
//  QuestionStrategyProtocol.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

// #strategy
protocol QuestionStrategyProtocol: AnyObject {
    func getNewQuestionModel(allQuestionModels: [QuestionModel], usedQuestionModels: [QuestionModel]?) -> QuestionModel?
}
