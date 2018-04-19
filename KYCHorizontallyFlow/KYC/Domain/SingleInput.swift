//
//  SingleInput.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct SingleInput: JSONDecodable {
    
    let answerId: String
    let validation: String
    let validationType: SingleInputValidationType
    let placeholder: String
    
    init(json: JSON) throws {
        let validationTypeString: String =
            try getValue(for: "validation_type", from: json)
        self.answerId = try getValue(for: "answer_id", from: json)
        self.validation = try getValue(for: "validation", from: json)
        self.validationType = SingleInputValidationType(value: validationTypeString)
        self.placeholder = try getValue(for: "placeholder", from: json)
    }
}
