//
//  Questions.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


class Defaults {
    static func getDefaultQuestions() -> [QuestionModel] {
        
        return [
            QuestionModel(id: 0, questionText: "Какой цвет у крокодила?", answerA: "Желтый", answerB: "Зеленый", answerC: "Красный", answerD: "Синий", trueAnswerEnum: .B),
            QuestionModel(id: 1, questionText: "Кто основал компанию Apple?", answerA: "Цукерберг", answerB: "Билл Гейтс", answerC: "Стив Джобс", answerD: "Сергей Брин", trueAnswerEnum: .C)
        ]
    }
}
