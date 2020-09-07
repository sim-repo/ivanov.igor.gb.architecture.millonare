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
    private var winAmount: Int = 0 // сумма выигрыша
    private var usedQuestionModels: [QuestionModel]?
    private var hintUsageFacade: HintFacade = HintFacade()
    private var curQuestion: QuestionModel?
    //#observable
    private var curQuestionNum: Observable<Int> = Observable(-1)
    
    init() {
        self.questionsFullAmount = loadQuestions().count
    }
    
    public func setViewController(vc: GameViewController) {
        self.vc = vc
    }
    
    private func addUsedQuestion(questionModel: QuestionModel) {
        if usedQuestionModels == nil {
            usedQuestionModels = []
        }
        usedQuestionModels?.append(questionModel)
    }
    
    //#memento
    private func loadQuestions() -> [QuestionModel] {
        if let questions = FilesManager.shared.loadQuestionModels(),
        questions.capacity > 0{
            return questions
        }
        let questions = Defaults.getDefaultQuestions()
        Game.shared.addQuestions(newQuestionModels: questions) // save default q into file
        return questions
    }
}

//MARK:- ReadableGameSessionProtocolDelegate
extension GameSession: StatisticableGameSessionProtocol {
    
    func getFullQuestionsAmount() -> Int {
        return questionsFullAmount
    }
    
    func getPassedQuestionsAmount() -> Int {
        return questionsPassedAmount
    }
    
    func getUsedQuestionModels() -> [QuestionModel]? {
        return usedQuestionModels
    }
}


//MARK:- GameSessionProtocolDelegate
extension GameSession: GameSessionProtocolDelegate {
    
    //#observable
    func getQuestionNumber() -> Observable<Int> {
        return curQuestionNum
    }
    
    //#strategy
    func getNextQuestion() -> QuestionModel? {
        
        let allQuestions = loadQuestions()
        let usedQuestions = getUsedQuestionModels()
        let questionStrategyChooser = QuestionStrategyChooser(strategy: Game.shared.getQuestionSeguenceEnum())
        curQuestion = questionStrategyChooser.getNewQuestionModel(allQuestionModels: allQuestions, usedQuestionModels: usedQuestions)
        curQuestionNum.value = curQuestion?.id ?? 1 //#observable
        if let question = curQuestion {
            addUsedQuestion(questionModel: question)
        }
        return curQuestion
    }
    
    func didSelectRightAnswer() {
        questionsPassedAmount += 1
    }
    
    private func setHint() {
         hintUsageFacade.setCurQuestion(curQuestionModel: curQuestion!)
    }
    
    func didPressHintAuditory() {
        setHint()
        guard let hints = hintUsageFacade.useAuditoryHelp() else { return }
        vc?.showHintAuditory(hints: hints)
    }
    
    func didPressHintCallFriend() {
        setHint()
        guard let hints = hintUsageFacade.callFriend()  else { return }
        
        vc?.showHintCallFriend(hint: hints)
    }
    
    func didPressFiftyPercent() {
        setHint()
        guard let hints = hintUsageFacade.use50to50Hint() else { return }
        
        vc?.showHint50x50(hints: hints)
    }
    
    func didGameFinish(winAmount: Int) {
        self.winAmount = winAmount
    }
}
