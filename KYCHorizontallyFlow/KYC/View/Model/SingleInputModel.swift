//
//  SingleInputModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class SingleInputModel: QuestionTypeProtocol {
    
    let questionId: String
    let isMandatory: Bool
    let title: String
    let type: QuestionType
    let answerId: String
    let placeholder: String
    let validation: String
    let validationType: SingleInputValidationType
    let keyboard: KeyboardSingleInput
    
    init(question: Question) {
        questionId = question.id
        isMandatory = question.isMandatory
        title = question.title
        type = question.type
        let meta = question.meta as! SingleInput
        answerId = meta.answerId
        placeholder = meta.placeholder
        validation = meta.validation
        validationType = meta.validationType
        keyboard = KeyboardSingleInput(for: validationType)
    }
}
