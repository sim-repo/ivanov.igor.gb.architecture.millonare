//
//  GameSession.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class GameSession {
    
    private var vc: GameViewController?
    
    // game session states:
    private var questionsPassedAmount: Int = 0 // кол-во отвеченных вопросов
    private var questionsFullAmount: Int = 0 // всего вопросов
    private var hintUsedAuditory: Bool = false // помощь зала
    private var hintUsedCallFriend: Bool = false // звонок другуы
    private var hintUsedFiftyPercent: Bool = false // 50x50
    private var winAmount: Int = 0 // сумма выигрыша
    
    
    public func setViewController(vc: GameViewController) {
        self.vc = vc
    }
}

//MARK:- ReadableGameSessionProtocolDelegate
extension GameSession: ReadableGameSessionProtocolDelegate {
    
    func getFullQuestionsAmount() -> Int {
        return questionsFullAmount
    }
    
    func getPassedQuestionsAmount() -> Int {
        return questionsPassedAmount
    }
}


//MARK:- GameSessionProtocolDelegate
extension GameSession: GameSessionProtocolDelegate {

    func setQuestionsAmount(_ questionsAmount: Int) {
        self.questionsFullAmount = questionsAmount
    }
    
    func didSelectRightAnswer() {
        questionsPassedAmount += 1
    }
    
    func didPressHintAuditory() {
        hintUsedAuditory = true
    }
    
    func didPressHintCallFriend() {
        hintUsedCallFriend = true
    }
    
    func didPressFiftyPercent() {
        hintUsedFiftyPercent = true
    }
    
    func didGameFinish(winAmount: Int) {
        self.winAmount = winAmount
    }
}
