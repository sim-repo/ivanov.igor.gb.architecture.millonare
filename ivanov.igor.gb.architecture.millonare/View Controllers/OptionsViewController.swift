//
//  OptionsViewController.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

// #strategy
class OptionsViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setOutlets(){
        textField.delegate = self
        pickerView.isHidden = true
    }
}




//MARK:- UIPicker Delegate
extension OptionsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let seq = QuestionSequenceEnum.allCases[row]
        textField.text = seq.rawValue
        pickerView.isHidden = true
        Game.shared.setQuestionSequence(sequence: seq) // #builder
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: QuestionSequenceEnum.allCases[row].rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }
}


//MARK:- Text Field Delegate
extension OptionsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textField {
            pickerView.isHidden = false
            textField.endEditing(true)
        }
    }
}
