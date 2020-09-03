//
//  GameViewController.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private var gameSession: GameSessionProtocolDelegate?
    private var timer: Timer?
    
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerLabelA: UILabel!
    @IBOutlet weak var answerLabelB: UILabel!
    @IBOutlet weak var answerLabelC: UILabel!
    @IBOutlet weak var answerLabelD: UILabel!
    
    private var roundNum: Int = -1
    private var curQuestion: Question?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goNextRound()
    }
    
    public func setup(gameSession: GameSessionProtocolDelegate) {
        self.gameSession = gameSession
        self.gameSession?.setViewController(vc: self)
        self.gameSession?.setQuestionsAmount(getQuestions().count) // передаем всего вопросов
    }
}

//MARK:- button actions
extension GameViewController {
    
    @IBAction func pressButtonA(_ sender: Any) {
        checkAnswer(selectedAnswerId: 0)
    }
    
    @IBAction func pressButtonB(_ sender: Any) {
        checkAnswer(selectedAnswerId: 1)
    }
    
    @IBAction func pressButtonC(_ sender: Any) {
        checkAnswer(selectedAnswerId: 2)
    }
    
    @IBAction func pressButtonD(_ sender: Any) {
        checkAnswer(selectedAnswerId: 3)
    }
    
    @IBAction func pressHintAuditory(_ sender: Any) {
        gameSession?.didPressHintAuditory() // передаем подсказку
        showHint()
    }
    
    @IBAction func pressHintCallFriend(_ sender: Any) {
        gameSession?.didPressHintCallFriend() // передаем подсказку
        showHint()
    }
    
    @IBAction func pressHintFiftyPercent(_ sender: Any) {
        gameSession?.didPressFiftyPercent() // передаем подсказку
        showHint()
    }
}


//MARK:- hints
extension GameViewController {
    
    private func showHint() {
        guard let question = curQuestion else { return }
        showAnswers(question.rightAnswerId)
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.resetColor), userInfo: nil, repeats: false)
    }
}


//MARK:- flow
extension GameViewController {
    
    private func checkAnswer(selectedAnswerId: Int) {
        guard let question = curQuestion else { return }
        if question.rightAnswerId == selectedAnswerId {
            gameSession?.didSelectRightAnswer() // передаем что ответ правильный
        }
        showAnswers(selectedAnswerId)
        timer?.invalidate()
        if selectedAnswerId == question.rightAnswerId,
            roundNum + 1 < getQuestions().count {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.goNextRound), userInfo: nil, repeats: false)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.gameFinish), userInfo: nil, repeats: false)
        }
    }
    
    
    private func showAnswers(_ selectedAnswerId: Int) {
        guard let question = curQuestion else { return }
        answerLabelA.backgroundColor = question.rightAnswerId == 0 ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        answerLabelB.backgroundColor = question.rightAnswerId == 1 ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        answerLabelC.backgroundColor = question.rightAnswerId == 2 ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        answerLabelD.backgroundColor = question.rightAnswerId == 3 ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        view.setNeedsDisplay()
    }
    
    
    @objc private func goNextRound() {
        resetColor()
        roundNum += 1
        curQuestion = getQuestions()[roundNum]
        questionTextView.text = curQuestion?.questionText
        answerLabelA.text = curQuestion?.answerA
        answerLabelB.text = curQuestion?.answerB
        answerLabelC.text = curQuestion?.answerC
        answerLabelD.text = curQuestion?.answerD
        view.setNeedsDisplay()
    }
    
    
    @objc private func resetColor() {
        answerLabelA.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        answerLabelB.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        answerLabelC.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        answerLabelD.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    }
    
    @objc private func gameFinish() {
        let winAmt = roundNum * 100
        gameSession?.didGameFinish(winAmount: winAmt)
        dismiss(animated: true, completion: nil)
    }
}

