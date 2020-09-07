//
//  QuestionBuilder.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#builder
class QuestionBuilder {
    
    private var curQuestionModel: QuestionModel?
    private var questionModels: [QuestionModel] = []
    
    private var questionText: String?
    private var answerA: String?
    private var answerB: String?
    private var answerC: String?
    private var answerD: String?
    private var trueAnswerEnum: AnswerEnum = .A
    
    public func createQuestion() {
        curQuestionModel = QuestionModel()
        questionModels.append(curQuestionModel!)
    }
    
    public func setQuestionText(text: String) {
        curQuestionModel?.questionText = text
    }
    
    public func setAnswerA(text: String) {
        curQuestionModel?.answerA = text
    }
    
    public func setAnswerB(text: String) {
        curQuestionModel?.answerB = text
    }
    
    public func setAnswerC(text: String) {
        curQuestionModel?.answerC = text
    }
    
    public func setAnswerD(text: String) {
        curQuestionModel?.answerD = text
    }
    
    public func setTrueAnswer(answerEnum: AnswerEnum) {
        curQuestionModel?.trueAnswerEnum = answerEnum
    }
    
    public func build() -> [QuestionModel] {
        return questionModels
    }
}
