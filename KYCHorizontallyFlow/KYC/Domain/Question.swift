//
//  Question.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct Question: JSONDecodable {
    
    let id: String
    let isMandatory: Bool
    let title: String
    let type: QuestionType
    let meta: JSONDecodable
    
    init(json: JSON) throws {
        id = try getValue(for: "question_id", from: json)
        isMandatory = try getValue(for: "mandatory", from: json)
        title = try getValue(for: "question_title", from: json)
        type = try QuestionType(json: json)
        
        switch type {
        case .singleInput:
            let model: SingleInput = try getModel(for: "single-input-meta", from: json)
            meta = model
        case .singleChoice:
            let model: SingleChoice = try getModel(for: "single-choice-meta", from: json)
            meta = model
        }
    }
}
