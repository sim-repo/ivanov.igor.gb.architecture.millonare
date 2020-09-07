//
//  HintFiftyPercentService.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

//#facade
final class HintFiftyPercentService {
 
    public static func getHint(questionModel: QuestionModel) -> (AnswerEnum, AnswerEnum) {
        //calc here
        let trueAnswer = questionModel.trueAnswerEnum!
        let falseAnswer = getFalseAnswer(questionModel)
        return (trueAnswer, falseAnswer)
    }
    
    private static func getFalseAnswer(_ questionModel: QuestionModel) -> AnswerEnum {
        let idx = Int.random(in: 0...2)
        switch questionModel.trueAnswerEnum {
        case .A:
            let mix: [AnswerEnum] = [.B, .C, .D]
            return mix[idx]
        case .B:
            let mix: [AnswerEnum] = [.A, .C, .D]
            return mix[idx]
        case .C:
            let mix: [AnswerEnum] = [.A, .B, .D]
            return mix[idx]
        case .D:
            let mix: [AnswerEnum] = [.A, .B, .C]
            return mix[idx]
        case .none:
            fatalError("HintFiftyPercentService.getFalseAnswer(): error has occured")
        }
    }
}
