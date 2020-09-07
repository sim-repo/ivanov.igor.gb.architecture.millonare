//
//  CreateQuestionTableViewCell.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class CreateQuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerALabel: UITextField!
    @IBOutlet weak var answerBLabel: UITextField!
    @IBOutlet weak var answerCLabel: UITextField!
    @IBOutlet weak var answerDLabel: UITextField!
    @IBOutlet weak var sequenceSegment: UISegmentedControl!
    
    private var questionBuilder: QuestionBuilder!
    private var primitiveQuestion: CreateQuestionsViewController.PrimitiveQuestion?
    
    func setup(questionBuilder: QuestionBuilder, primitiveQuestion: CreateQuestionsViewController.PrimitiveQuestion) {
        self.primitiveQuestion = primitiveQuestion
        self.questionBuilder = questionBuilder
        setupOutlets()
    }
    
    private func canEdit() -> Bool {
        guard let txt = primitiveQuestion?.questionText,
            let txt2 = primitiveQuestion?.answerA,
            let txt3 = primitiveQuestion?.answerA,
            let txt4 = primitiveQuestion?.answerA
        else { return true }
        return txt.count > 0 &&
               txt2.count > 0 &&
               txt3.count > 0 &&
               txt4.count > 0
        ? false : true
    }
    
    private func setupOutlets() {
        questionTextView.text = primitiveQuestion?.questionText
        sequenceSegment.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        answerALabel.text = primitiveQuestion?.answerA
        answerBLabel.text = primitiveQuestion?.answerB
        answerCLabel.text = primitiveQuestion?.answerC
        answerDLabel.text = primitiveQuestion?.answerD
        questionTextView.isEditable = canEdit() ? true : false
        answerALabel.isEnabled = canEdit() ? true : false
        answerBLabel.isEnabled = canEdit() ? true : false
        answerCLabel.isEnabled = canEdit() ? true : false
        answerDLabel.isEnabled = canEdit() ? true : false
    }
}

//MARK:- Segmented Control
extension CreateQuestionTableViewCell {
    
    // #builder
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if sequenceSegment.selectedSegmentIndex == 0 {
            primitiveQuestion?.trueAnswerEnum = .A
            questionBuilder.setTrueAnswer(answerEnum: .A)
        } else if sequenceSegment.selectedSegmentIndex == 1 {
            primitiveQuestion?.trueAnswerEnum = .B
            questionBuilder.setTrueAnswer(answerEnum: .B)
        } else if sequenceSegment.selectedSegmentIndex == 2 {
            primitiveQuestion?.trueAnswerEnum = .C
            questionBuilder.setTrueAnswer(answerEnum: .C)
        } else if sequenceSegment.selectedSegmentIndex == 3 {
            primitiveQuestion?.trueAnswerEnum = .D
            questionBuilder.setTrueAnswer(answerEnum: .D)
        }
    }
}

//MARK:- Text Field Delegate
// #builder
extension CreateQuestionTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.answerALabel,
            let txt = textField.text{
            questionBuilder.setAnswerA(text: txt)
            primitiveQuestion?.answerA = txt
        }
        
        if textField == self.answerBLabel,
            let txt = textField.text{
            questionBuilder.setAnswerB(text: txt)
            primitiveQuestion?.answerB = txt
        }
        
        if textField == self.answerCLabel,
            let txt = textField.text{
            questionBuilder.setAnswerC(text: txt)
            primitiveQuestion?.answerC = txt
        }
        
        if textField == self.answerDLabel,
            let txt = textField.text{
            questionBuilder.setAnswerD(text: txt)
            primitiveQuestion?.answerD = txt
        }
    }
}


//MARK:- Text View Delegate
// #builder
extension CreateQuestionTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.questionTextView,
            let txt = textView.text {
            questionBuilder.setQuestionText(text: txt)
            primitiveQuestion?.questionText = txt
        }
    }
}



