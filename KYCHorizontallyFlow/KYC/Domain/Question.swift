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
    
    init(json: JSON) throws {
        self.id = try getValue(for: "question_id", from: json)
        self.isMandatory = try getValue(for: "mandatory", from: json)
        self.title = try getValue(for: "question_title", from: json)
        self.type = try QuestionType(json: json)
    }
}
