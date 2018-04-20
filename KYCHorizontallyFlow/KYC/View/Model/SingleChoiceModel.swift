//
//  SingleChoiceModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class SingleChoiceModel: QuestionTypeProtocol {
    
    let questionId: String
    let isMandatory: Bool
    let title: String
    let type: QuestionType
    let numberOfAnswers: Int
    let answers: [Answer]
    
    init(question: Question) {
        questionId = question.id
        isMandatory = question.isMandatory
        title = question.title
        type = question.type
        let meta = question.meta as! SingleChoice
        answers = meta.answers
        numberOfAnswers = answers.count
    }
}
