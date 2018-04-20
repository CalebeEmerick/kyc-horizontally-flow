//
//  AnswerCell.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 20/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class AnswerCell: UITableViewCell {
    
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet private var answerLabel: UILabel!
    @IBOutlet private var questionId: UILabel!
    @IBOutlet private var answerId: UILabel!
    
    var answer: QuestionAnswer? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let answer = answer else { return }
        DispatchQueue.main.async {
            self.questionLabel.text = answer.question
            self.answerLabel.text = "R - " + answer.answer
            self.questionId.text = answer.questionId
            self.answerId.text = answer.answerId
        }
    }
}
