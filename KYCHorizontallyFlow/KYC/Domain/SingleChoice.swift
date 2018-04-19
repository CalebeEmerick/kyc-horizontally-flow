//
//  SingleChoice.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct SingleChoice: JSONDecodable {
    
    let answers: [Answer]
    
    init(json: JSON) throws {
        let answers: [Answer] = try getList(for: "answers", from: json)
        self.answers = answers
    }
}
