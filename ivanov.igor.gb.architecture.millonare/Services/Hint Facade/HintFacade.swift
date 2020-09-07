//
//  HintFacade.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

//#facade
class HintFacade {
    
    private var curQuestionModel: QuestionModel!
    private var usedHintCallFriend: Bool = false
    private var usedHintAuditory: Bool = false
    
    // 50x50:
    private var usedHint50x50: Bool = false
    private var questionIdUsed50x50: Int = -1
    private var trueAnswerIn50x50: AnswerEnum?
    private var falseAnswerIn50x50: AnswerEnum?
    
    
    public func setCurQuestion(curQuestionModel: QuestionModel) {
        self.curQuestionModel = curQuestionModel
    }
    
    public func callFriend() -> AnswerEnum? {
        guard usedHintCallFriend == false else { return nil }
        usedHintCallFriend = true
        if isQuestionUsed50x50() {
               return HintCallFriendService.getHint(trueAnswer: trueAnswerIn50x50!, falseAnswer: falseAnswerIn50x50!)
           }
           return HintCallFriendService.getHint(questionModel: curQuestionModel)
    }
    
    public func useAuditoryHelp() -> [Int:AnswerEnum]? {
        guard usedHintAuditory == false else { return nil }
        usedHintAuditory = true
        if isQuestionUsed50x50() {
            return HintAuditoryService.getHint(trueAnswer: trueAnswerIn50x50!, falseAnswer: falseAnswerIn50x50!)
        }
        return HintAuditoryService.getHint(questionModel: curQuestionModel)
    }
    

    public func use50to50Hint() -> [AnswerEnum]? {
        guard usedHint50x50 == false else { return nil }
        questionIdUsed50x50 = curQuestionModel.id!
        usedHint50x50 = true
        (trueAnswerIn50x50, falseAnswerIn50x50) = HintFiftyPercentService.getHint(questionModel: curQuestionModel)
        
        var res: [AnswerEnum] = []
        let idx = Int.random(in: 0...1)
               if idx == 0 {
                   res.append(contentsOf: [trueAnswerIn50x50!, falseAnswerIn50x50!])
               } else {
                   res.append(contentsOf: [falseAnswerIn50x50!, trueAnswerIn50x50!])
               }
        return res
    }
    
    private func isQuestionUsed50x50() -> Bool {
        return questionIdUsed50x50 == curQuestionModel.id
    }
}
