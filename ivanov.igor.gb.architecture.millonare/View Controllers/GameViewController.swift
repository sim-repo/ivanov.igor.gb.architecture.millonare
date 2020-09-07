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
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabelA: UILabel!
    @IBOutlet weak var answerLabelB: UILabel!
    @IBOutlet weak var answerLabelC: UILabel!
    @IBOutlet weak var answerLabelD: UILabel!
    
    //hint outlets
    
    @IBOutlet weak var hintMainView: UIView!
    @IBOutlet weak var hintAnswerLabelA: UILabel!
    @IBOutlet weak var hintAnswerLabelB: UILabel!
    @IBOutlet weak var hintAnswerLabelC: UILabel!
    @IBOutlet weak var hintAnswerLabelD: UILabel!
    
    @IBOutlet weak var hintPA: UILabel!
    @IBOutlet weak var hintPB: UILabel!
    @IBOutlet weak var hintPC: UILabel!
    @IBOutlet weak var hintPD: UILabel!
    
    @IBOutlet weak var questionNum: UILabel!
    
    
    private var roundNum: Int = -1
    private var curQuestion: QuestionModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideHints()
        setupOutlets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkNextRound()
    }
    
    public func setup(gameSession: GameSessionProtocolDelegate) {
        self.gameSession = gameSession
        self.gameSession?.setViewController(vc: self)
    }
    
    private func setupOutlets() {
        gameSession?.getQuestionNumber().addObserver(self, options: [.initial, .new]) {[weak self] (res,_) in
            guard let self = self else { return }
            self.questionNum.text = "\(res)"
        }
    }
}

//MARK:- button actions
extension GameViewController {
    
    @IBAction func pressButtonA(_ sender: Any) {
        checkAnswer(selectedAnswerEnum: .A)
    }
    
    @IBAction func pressButtonB(_ sender: Any) {
        checkAnswer(selectedAnswerEnum: .B)
    }
    
    @IBAction func pressButtonC(_ sender: Any) {
        checkAnswer(selectedAnswerEnum: .C)
    }
    
    @IBAction func pressButtonD(_ sender: Any) {
        checkAnswer(selectedAnswerEnum: .D)
    }
    
    @IBAction func pressHintAuditory(_ sender: Any) {
        gameSession?.didPressHintAuditory() // передаем подсказку
    }
    
    @IBAction func pressHintCallFriend(_ sender: Any) {
        gameSession?.didPressHintCallFriend() // передаем подсказку
    }
    
    @IBAction func pressHintFiftyPercent(_ sender: Any) {
        gameSession?.didPressFiftyPercent() // передаем подсказку
    }
}


//MARK:- hints
extension GameViewController {
    
    
    private func hideHints() {
        hintMainView.isHidden = true
        hintAnswerLabelA.text = ""
        hintAnswerLabelB.text = ""
        hintAnswerLabelC.text = ""
        hintAnswerLabelD.text = ""
        hintPA.text = ""
        hintPB.text = ""
        hintPC.text = ""
        hintPD.text = ""
    }
    
    private func showHints() {
        hintMainView.isHidden = false
    }
}


//MARK:- flow
extension GameViewController {
    
    private func checkAnswer(selectedAnswerEnum: AnswerEnum) {
        guard let question = curQuestion else { return }
        if question.trueAnswerEnum == selectedAnswerEnum {
            gameSession?.didSelectRightAnswer() // передаем что ответ правильный
            showAnswers()
            checkNextRound()
            return
        }
        goFinish()
    }
    
    private func checkNextRound() {
        hideHints()
        if let q = gameSession?.getNextQuestion() {
            curQuestion = q
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.goNextRound), userInfo: nil, repeats: false)
        } else {
            goFinish()
        }
    }
    
    private func showAnswers() {
        guard let question = curQuestion else { return }
        answerLabelA.backgroundColor = question.trueAnswerEnum == .A ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        answerLabelB.backgroundColor = question.trueAnswerEnum == .B ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        answerLabelC.backgroundColor = question.trueAnswerEnum == .C ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        answerLabelD.backgroundColor = question.trueAnswerEnum == .D ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        view.setNeedsDisplay()
    }
    
    
    @objc private func goNextRound() {
        resetColor()
        questionLabel.text = curQuestion?.questionText
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
    
    private func goFinish() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.gameFinish), userInfo: nil, repeats: false)
    }
    
    @objc private func gameFinish() {
        let winAmt = roundNum * 100
        gameSession?.didGameFinish(winAmount: winAmt)
        navigationController?.popViewController(animated: true)
    }
}


//MARK:- presentable
extension GameViewController {
    
    public func showHintAuditory(hints: [Int:AnswerEnum]) {
        hideHints()
        showHints()
        for (_,rec) in hints.enumerated() {
            let P = "\(rec.key)%"
            setAnswerLabel(rec.value)
            switch rec.value {
            case .A:
                hintPA.text = P
            case .B:
                hintPB.text = P
            case .C:
                hintPC.text = P
            case .D:
                hintPD.text = P
            }
        }
        view.layoutIfNeeded()
    }
    
    public func showHintCallFriend(hint: AnswerEnum) {
        hideHints()
        showHints()
        setAnswerLabel(hint)
    }
    
    public func showHint50x50(hints: [AnswerEnum]) {
        hideHints()
        showHints()
        for hint in hints {
            setAnswerLabel(hint)
        }
    }
    
    
    private func setAnswerLabel(_ hint: AnswerEnum) {
        switch hint {
        case .A:
            hintAnswerLabelA.text = hint.rawValue
        case .B:
            hintAnswerLabelB.text = hint.rawValue
        case .C:
            hintAnswerLabelC.text = hint.rawValue
        case .D:
            hintAnswerLabelD.text = hint.rawValue
        }
    }
}
