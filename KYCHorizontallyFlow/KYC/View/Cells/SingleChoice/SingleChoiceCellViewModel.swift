//
//  SingleChoiceCellViewModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class SingleChoiceCellViewModel: CellViewModelProtocol {
    
    let model: SingleChoiceModel
    let questionType: QuestionType
    
    var answer: AnswerState = .none
    
    var selectedIndexPath: IndexPath! {
        didSet {
            updateAnswer()
        }
    }
    
    init(model: SingleChoiceModel) {
        self.model = model
        self.questionType = model.type
    }
    
    private func updateAnswer() {
        let answer = model.answers[selectedIndexPath.row]
        let questionAnswer = QuestionAnswer(questionId: model.questionId,
                                            answerId: answer.id,
                                            question: model.title,
                                            answer: answer.description
        )
        self.answer = .answered(with: questionAnswer)
    }
}
