//
//  SingleChoiceModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class SingleChoiceModel: QuestionTypeProtocol {
    
    typealias QuestionAnswer = (id: String, answer: String)
    
    let questionId: String
    let isMandatory: Bool
    let title: String
    let type: QuestionType
    let numberOfAnswers: Int
    let answers: [Answer]
    
    var answer: AnswerState = .none
    
    init(question: Question) {
        questionId = question.id
        isMandatory = question.isMandatory
        title = question.title
        type = question.type
        let meta = question.meta as! SingleChoice
        answers = meta.answers
        numberOfAnswers = answers.count
    }
    
    enum AnswerState {
        case none
        case selected(QuestionAnswer)
    }
}
