//
//  QuestionModel.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


final class QuestionModel: HashableClass, Codable {
    
    
    var id: Int?
    var questionText: String?
    var answerA: String?
    var answerB: String?
    var answerC: String?
    var answerD: String?
    var trueAnswerEnum: AnswerEnum?
    
    override init() {
        
    }
    
    internal init(id: Int? = nil, questionText: String? = nil, answerA: String? = nil, answerB: String? = nil, answerC: String? = nil, answerD: String? = nil, trueAnswerEnum: AnswerEnum? = nil) {
        self.id = id
        self.questionText = questionText
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.trueAnswerEnum = trueAnswerEnum
    }
    
    //MARK:- Codable >>
    enum CodingKeys: String, CodingKey {
        case id
        case questionText
        case answerA
        case answerB
        case answerC
        case answerD
        case trueAnswerEnum
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(questionText, forKey: .questionText)
        try container.encode(answerA, forKey: .answerA)
        try container.encode(answerB, forKey: .answerB)
        try container.encode(answerC, forKey: .answerC)
        try container.encode(answerD, forKey: .answerD)
        try container.encode(trueAnswerEnum?.rawValue, forKey: .trueAnswerEnum)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        questionText = try container.decode(String.self, forKey: .questionText)
        answerA = try container.decode(String.self, forKey: .answerA)
        answerB = try container.decode(String.self, forKey: .answerB)
        answerC = try container.decode(String.self, forKey: .answerC)
        answerD = try container.decode(String.self, forKey: .answerD)
        let trueAnswerStr = try container.decode(String.self, forKey: .trueAnswerEnum)
        trueAnswerEnum = AnswerEnum.init(rawValue: trueAnswerStr)
    }
}
