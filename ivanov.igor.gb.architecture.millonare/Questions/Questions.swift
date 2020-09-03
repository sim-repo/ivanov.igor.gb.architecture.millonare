//
//  Questions.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


struct Question {
    var questionText: String
    var answerA: String
    var answerB: String
    var answerC: String
    var answerD: String
    var rightAnswerId: Int
}

func getQuestions() -> [Question] {
    
    return [
        Question(questionText: "Какой цвет у крокодила?", answerA: "Желтый", answerB: "Зеленый", answerC: "Красный", answerD: "Синий", rightAnswerId: 1),
        Question(questionText: "Кто основал компанию Apple?", answerA: "Цукерберг", answerB: "Билл Гейтс", answerC: "Стив Джобс", answerD: "Сергей Брин", rightAnswerId: 2)
    ]
}
