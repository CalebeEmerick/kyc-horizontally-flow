//
//  QuestionTypeProtocol.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

protocol QuestionTypeProtocol {
    
    var questionId: String { get }
    var isMandatory: Bool { get }
    var title: String { get }
    var type: QuestionType { get }
}
