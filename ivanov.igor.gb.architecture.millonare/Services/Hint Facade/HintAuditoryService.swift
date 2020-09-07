//
//  HintAuditoryService.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

//#facade
final class HintAuditoryService {
    
    public static func getHint(questionModel: QuestionModel) -> [Int:AnswerEnum]? {

        let probabilities: [Int] = getProbability(questionModel)
        
        return [probabilities[0]:.A,
                probabilities[1]:.B,
                probabilities[2]:.C,
                probabilities[3]:.D
        ]
    }
    
    
    private static func getProbability(_ questionModel: QuestionModel) -> [Int] {
        let P1: Int = Int.random(in: 30...60)
        let P2: Int = Int.random(in: 0..<100-P1)
        let P3: Int = Int.random(in: 0..<100-P1-P2)
        let P4: Int = 100 - P1 - P2 - P3
        
        switch questionModel.trueAnswerEnum {
        case .A:
            return [P1, P2, P3, P4]
        case .B:
            return [P2, P1, P3, P4]
        case .C:
            return [P2, P3, P1, P4]
        case .D:
            return [P4, P2, P3, P1]
        case .none:
            fatalError("HintFiftyPercentService.getFalseAnswer(): error has occured")
        }
    }
}

// when used 50x50
extension HintAuditoryService {
    
    public static func getHint(trueAnswer: AnswerEnum, falseAnswer: AnswerEnum) -> [Int:AnswerEnum]? {
        let P1: Int = Int.random(in: 30...60)
        let P2: Int = Int.random(in: 0..<100-P1)
        
        return [P1:trueAnswer,
                P2:falseAnswer]
    }
}
