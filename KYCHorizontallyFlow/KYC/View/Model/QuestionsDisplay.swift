//
//  QuestionsDisplay.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class QuestionsDisplay {
    
    let numberOfQuestions: Int
    let questions: [QuestionTypeProtocol]
    
    init(questions: [QuestionTypeProtocol]) {
        self.questions = questions
        self.numberOfQuestions = questions.count
    }
}
