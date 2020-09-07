//
//  HintCallFriendService.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

//#facade
final class HintCallFriendService {
    
    public static func getHint(questionModel: QuestionModel) -> AnswerEnum {
        let P = Int.random(in: 0...100)
        if P >= 30 {
            return questionModel.trueAnswerEnum!
        } else {
            return getFalseAnswer(questionModel)
        }
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


// when used 50x50
extension HintCallFriendService {
    
    public static func getHint(trueAnswer: AnswerEnum, falseAnswer: AnswerEnum) -> AnswerEnum {
        let P1: Int = Int.random(in: 30...60)
        let P2: Int = Int.random(in: 0..<100-P1)
        
        if P1 > P2 {
            return trueAnswer
        }
        return falseAnswer
    }
}
