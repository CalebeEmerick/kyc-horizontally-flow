//
//  QuestionsResponse.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct QuestionsResponse: JSONDecodable {
    
    let meta: MetaResponse
    let questions: [Question]
    
    init(json: JSON) throws {
        let meta: MetaResponse = try getModel(for: "meta", from: json)
        let questions: [Question] = try getList(for: "questions", from: json)
        self.meta = meta
        self.questions = questions
    }
}
