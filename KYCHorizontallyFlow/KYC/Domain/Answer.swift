//
//  Answer.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct Answer: JSONDecodable {
    
    let id: String
    let description: String
    
    init(json: JSON) throws {
        id = try getValue(for: "answer_id", from: json)
        description = try getValue(for: "description", from: json)
    }
    
    
}
