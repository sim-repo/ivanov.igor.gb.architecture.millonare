//
//  CreateQuestionsViewController.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 06.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class CreateQuestionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var newPrimitiveQuestions: [PrimitiveQuestion]?
    private var curPrimitiveQuestion: PrimitiveQuestion?
    private var questionBuider: QuestionBuilder = QuestionBuilder()
    
    class PrimitiveQuestion {
        var questionText: String?
        var answerA: String?
        var answerB: String?
        var answerC: String?
        var answerD: String?
        var trueAnswerEnum: AnswerEnum?
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK:- Add Question
extension CreateQuestionsViewController {
    
    @IBAction func pressAddQuestion(_ sender: Any) {
        guard canCreate() else { return }
        curPrimitiveQuestion = PrimitiveQuestion()
        if newPrimitiveQuestions == nil {
            newPrimitiveQuestions = []
        }
        questionBuider.createQuestion() // #builder
        newPrimitiveQuestions?.append(curPrimitiveQuestion!)
        tableView.reloadData()
    }
    
    private func canCreate() -> Bool {
        guard let cur = curPrimitiveQuestion else { return true }
        return cur.answerA != nil && cur.answerA != "" &&
               cur.answerB != nil && cur.answerB != "" &&
               cur.answerC != nil && cur.answerC != "" &&
               cur.answerD != nil && cur.answerD != "" &&
               cur.questionText != nil && cur.questionText != ""
    }
}


//MARK:- Commit Questions
// #builder
extension CreateQuestionsViewController {
    @IBAction func pressCommitQuestions(_ sender: UIButton) {
        guard canCreate() else { return }
        Game.shared.addQuestions(newQuestionModels: questionBuider.build())
    }
}


//MARK:- Table View Datasource
extension CreateQuestionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPrimitiveQuestions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qcell", for: indexPath) as! CreateQuestionTableViewCell
        cell.setup(questionBuilder: questionBuider, primitiveQuestion: newPrimitiveQuestions![indexPath.row])
        return cell
    }
}
