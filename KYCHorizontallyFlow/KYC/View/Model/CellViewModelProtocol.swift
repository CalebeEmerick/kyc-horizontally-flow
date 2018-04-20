//
//  CellViewModelProtocol.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 18/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

struct QuestionAnswer {
    
    let questionId: String
    let answerId: String
    let question: String
    let answer: String
}

enum AnswerState {
    
    case none
    case answered(with: QuestionAnswer)
}

protocol CellViewModelProtocol: AnyObject {
    
    var questionType: QuestionType { get }
    var answer: AnswerState { get set }
}
