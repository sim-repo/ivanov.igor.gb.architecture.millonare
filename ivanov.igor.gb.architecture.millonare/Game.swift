//
//  Game.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class Game {
    
    static var shared: Game = Game()
    private init() {}
    
    private var gameSession: StatisticableGameSessionProtocol?
    private var vc: MenuViewController?
    private var gameResults: [GameResult] = []
    private var questionSequenceEnum: QuestionSequenceEnum = .sequence// #strategy

    
    public func setViewController(vc: MenuViewController) {
        self.vc = vc
    }
    
    public func getGameSession() -> StatisticableGameSessionProtocol? {
        return gameSession
    }
    
    private func calcResults(questionsFullAmount: Int, questionsPassedAmount: Int) {
        let gameResult = GameResult(questionsPassedAmount: questionsPassedAmount, questionsFullAmount: questionsFullAmount)
        gameResults.append(gameResult)
        FilesManager.shared.saveGameResult(results: gameResults)
    }
    
    public func getQuestionSeguenceEnum() -> QuestionSequenceEnum {
        return questionSequenceEnum
    }
}

//MARK:- prevent create clone
extension Game: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}



extension Game {
    
    //#strategy
    public func setQuestionSequence(sequence: QuestionSequenceEnum) {
        self.questionSequenceEnum = sequence
    }
    

    //#memento
    public func addQuestions(newQuestionModels: [QuestionModel]) {
        return FilesManager.shared.saveNewQuestionModels(questionModels: newQuestionModels)
    }
}


//MARK:- delegate
extension Game: MenuProtocolDelegate {
    
    func didViewAppear() { // расчет результата игры
        guard let session = gameSession,
            session.getFullQuestionsAmount() > 0
        else { return }
        calcResults(questionsFullAmount: session.getFullQuestionsAmount(),
                    questionsPassedAmount: session.getPassedQuestionsAmount())
    }
    
    func didPressGameStart() {
        gameSession = GameSession()
    }
    
    func didPressResults() {
        //TODO: сделать экран результатов
    }
}
