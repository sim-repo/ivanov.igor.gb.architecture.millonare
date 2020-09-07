//
//  GameSessionProtocolDelegate.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

protocol GameSessionProtocolDelegate: AnyObject {
    func setViewController(vc: GameViewController)
    func getNextQuestion() -> QuestionModel? // #strategy
    func didSelectRightAnswer()
    func didPressHintAuditory()
    func didPressHintCallFriend()
    func didPressFiftyPercent()
    func didGameFinish(winAmount: Int)
    func getQuestionNumber() -> Observable<Int>
}


protocol StatisticableGameSessionProtocol: AnyObject {
    func getFullQuestionsAmount() -> Int
    func getPassedQuestionsAmount() -> Int
    func getUsedQuestionModels() -> [QuestionModel]?
}
